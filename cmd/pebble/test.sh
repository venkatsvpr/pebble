echo "Running badger"
rm testbench
go build -o testbench -tags badger

flags=" --duration=60s --initial-keys=10000000"

# echo "Workload A"
# rm -rf ./testfiles && mkdir ./testfiles || exit
# ./testbench  bench  ycsb ./testfiles/ --engine badger --workload A $flags

# rm -rf ./testfiles && mkdir ./testfiles || exit
# ./testbench  bench  ycsb ./testfiles/ --engine pebble --workload A $flags

# echo "Workload B"
# rm -rf ./testfiles && mkdir ./testfiles || exit
# ./testbench  bench  ycsb ./testfiles/ --engine badger --workload B $flags

# rm -rf ./testfiles && mkdir ./testfiles || exit
# ./testbench  bench  ycsb ./testfiles/ --engine pebble --workload B $flags

echo "Workload C"
rm -rf ./testfiles && mkdir ./testfiles || exit
./testbench  bench  ycsb ./testfiles/ --engine badger --workload C $flags

rm -rf ./testfiles && mkdir ./testfiles || exit
./testbench  bench  ycsb ./testfiles/ --engine pebble --workload C $flags

# echo "Workload D"
# rm -rf ./testfiles && mkdir ./testfiles || exit
# ./testbench  bench  ycsb ./testfiles/ --engine badger --workload D --duration=120s

# rm -rf ./testfiles && mkdir ./testfiles || exit
# ./testbench  bench  ycsb ./testfiles/ --engine pebble --workload D --duration=120s

# echo "Workload E"
# rm -rf ./testfiles && mkdir ./testfiles || exit
# ./testbench  bench  ycsb ./testfiles/ --engine badger --workload E --duration=120s

# rm -rf ./testfiles && mkdir ./testfiles || exit
# ./testbench  bench  ycsb ./testfiles/ --engine pebble --workload E --duration=120s

# rm -rf ./testfiles
