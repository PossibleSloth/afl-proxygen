#!/bin/sh

echo core >/proc/sys/kernel/core_pattern;
LD_LIBRARY_PATH=/usr/local/lib /opt/afl/afl-2.52b/afl-fuzz -i testcase_dir -o /opt/proxygen/results -m 500 ./test;
