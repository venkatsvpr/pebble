echo "Running badger"
go build -o testbench -tags badger

rm -rf ./dbfiles && mkdir ./dbfiles
./testbench  bench  ycsb ./dbfiles/ --engine badger --workload A

rm -rf ./dbfiles && mkdir ./dbfiles
./testbench  bench  ycsb ./dbfiles/ --engine badger --workload B

rm -rf ./dbfiles && mkdir ./dbfiles
./testbench  bench  ycsb ./dbfiles/ --engine badger --workload C


rm -rf ./dbfiles && mkdir ./dbfiles
./testbench  bench  ycsb ./dbfiles/ --engine badger --workload D

rm -rf ./dbfiles && mkdir ./dbfiles
./testbench  bench  ycsb ./dbfiles/ --engine badger --workload E

echo "Running pebble"
rm -rf ./dbfiles && mkdir ./dbfiles
./testbench  bench  ycsb ./dbfiles/ --engine pebble --workload A

rm -rf ./dbfiles && mkdir ./dbfiles
./testbench  bench  ycsb ./dbfiles/ --engine pebble --workload B

rm -rf ./dbfiles && mkdir ./dbfiles
./testbench  bench  ycsb ./dbfiles/ --engine pebble --workload C

rm -rf ./dbfiles && mkdir ./dbfiles
./testbench  bench  ycsb ./dbfiles/ --engine pebble --workload D

rm -rf ./dbfiles && mkdir ./dbfiles
./testbench  bench  ycsb ./dbfiles/ --engine pebble --workload E

rm -rf ./dbfiles && mkdir ./dbfiles





