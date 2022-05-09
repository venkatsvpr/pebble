// Copyright 2018 The LevelDB-Go and Pebble Authors. All rights reserved. Use
// of this source code is governed by a BSD-style license that can be found in
// the LICENSE file.

//go:build badger
// +build badger

package main

import (
	"bytes"
	"expvar"
	"log"

	"github.com/cockroachdb/pebble"
	"github.com/cockroachdb/pebble/internal/cache"
	"github.com/cockroachdb/pebble/sstable"
	"github.com/outcaste-io/badger/v3"
)

// Adapters for Badger.
type badgerDB struct {
	db *badger.DB
}

func newBadgerDB(dir string) DB {
	db, err := badger.Open(badger.DefaultOptions(dir))
	if err != nil {
		log.Fatal(err)
	}
	return &badgerDB{db}
}

func (b badgerDB) Name() string {
	return "badger"
}

func (b badgerDB) NewIter(opts *pebble.IterOptions) iterator {
	txn := b.db.NewTransaction(false)
	iopts := badger.DefaultIteratorOptions
	iopts.PrefetchValues = false

	return &badgerIterator{
		txn:   txn,
		iter:  txn.NewIterator(iopts),
		lower: opts.GetLowerBound(),
		upper: opts.GetUpperBound(),
	}
}

func (b badgerDB) NewBatch() batch {
	txn := b.db.NewTransaction(true)
	return &badgerBatch{txn}
}

func (b badgerDB) Scan(iter iterator, key []byte, count int64, reverse bool) error {
	panic("badgerDB.Scan: unimplemented")
}

func (b badgerDB) Metrics() *pebble.Metrics {
	return &pebble.Metrics{
		BlockCache: cache.Metrics{},
		Compact: struct {
			Count            int64
			DefaultCount     int64
			DeleteOnlyCount  int64
			ElisionOnlyCount int64
			MoveCount        int64
			ReadCount        int64
			RewriteCount     int64
			EstimatedDebt    uint64
			InProgressBytes  int64
			NumInProgress    int64
			MarkedFiles      int
		}{},
		Flush:  struct{ Count int64 }{},
		Filter: sstable.FilterMetrics{},
		Levels: [7]pebble.LevelMetrics{
			pebble.LevelMetrics{
				BytesRead:     uint64(expvar.Get("badger_v3_read_bytes").(*expvar.Int).Value()),
				BytesIngested: uint64(expvar.Get("badger_v3_written_bytes").(*expvar.Int).Value()),
			},
		},
		MemTable: struct {
			Size        uint64
			Count       int64
			ZombieSize  uint64
			ZombieCount int64
		}{},
		Snapshots: struct {
			Count          int
			EarliestSeqNum uint64
		}{},
		Table: struct {
			ObsoleteSize  uint64
			ObsoleteCount int64
			ZombieSize    uint64
			ZombieCount   int64
		}{},
		TableCache: cache.Metrics{},
		TableIters: 0,
		WAL: struct {
			Files                int64
			ObsoleteFiles        int64
			ObsoletePhysicalSize uint64
			Size                 uint64
			PhysicalSize         uint64
			BytesIn              uint64
			BytesWritten         uint64
		}{},
	}
}

func (b badgerDB) Flush() error {
	return nil
}

type badgerIterator struct {
	txn   *badger.Txn
	iter  *badger.Iterator
	buf   []byte
	lower []byte
	upper []byte
}

func (i *badgerIterator) SeekGE(key []byte) bool {
	i.iter.Seek(key)
	if !i.iter.Valid() {
		return false
	}
	if i.upper != nil && bytes.Compare(i.Key(), i.upper) >= 0 {
		return false
	}
	return true
}

func (i *badgerIterator) SeekLT(key []byte) bool {
	panic("not implemented")
	/*
		# venkat TODO: check if this is the right way to do
		if i.lower != nil && bytes.Compare(i.Key(), i.lower) <= 0 {
			return false
		}
		return true
	*/
}

func (i *badgerIterator) Valid() bool {
	return i.iter.Valid()
}

func (i *badgerIterator) Key() []byte {
	return i.iter.Item().Key()
}

func (i *badgerIterator) Value() []byte {
	var err error
	i.buf, err = i.iter.Item().ValueCopy(i.buf[:cap(i.buf)])
	if err != nil {
		log.Fatal(err)
	}
	return i.buf
}

func (i *badgerIterator) First() bool {
	return i.SeekGE(i.lower)
}

func (i *badgerIterator) Next() bool {
	i.iter.Next()
	if !i.iter.Valid() {
		return false
	}
	if i.upper != nil && bytes.Compare(i.Key(), i.upper) >= 0 {
		return false
	}
	return true
}

func (i *badgerIterator) Last() bool {
	return false
}

func (i *badgerIterator) Prev() bool {
	return false
}

func (i *badgerIterator) Close() error {
	i.iter.Close()
	i.txn.Discard()
	return nil
}

type badgerBatch struct {
	txn *badger.Txn
}

func (b badgerBatch) Close() error {
	return nil
}

func (b badgerBatch) Commit(opts *pebble.WriteOptions) error {
	return b.txn.Commit()
}

func (b badgerBatch) Set(key, value []byte, _ *pebble.WriteOptions) error {
	return b.txn.Set(key, value)
}

func (b badgerBatch) Delete(key []byte, _ *pebble.WriteOptions) error {
	return b.txn.Delete(key)
}

func (b badgerBatch) LogData(data []byte, _ *pebble.WriteOptions) error {
	panic("badgerBatch.logData: unimplemented")
}
