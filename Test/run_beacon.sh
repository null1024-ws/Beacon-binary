#!/bin/bash

set -x 
mkdir -p outputs
cd outputs
/Beacon/precondInfer /Beacon/Test/swftophp-2017-7578.bc --target-file=/Beacon/Test/cstest.txt --join-bound=5 >precond_log 2>&1

/Beacon/Ins -output=/Beacon/Test/CVE-2017-7578.bc -src -blocks=/Beacon/Test/bbreaches-CVE-2017-7578.txt -afl -log=log.txt -load=/Beacon/Test/outputs/range_res.txt /Beacon/Test/outputs/transed.bc

clang /Beacon/Test/CVE-2017-7578.bc -o /Beacon/Test/CVE-2017-7578 -lm -lz /Beacon/Test/afl-llvm-rt.o

/Beacon/afl-fuzz -i /Beacon/Test/in -o /Beacon/Test/fuzz-output -m none -t 9999 -d -- /Beacon/Test/CVE-2017-7578 @@
