#!/bin/sh

LD_LIBRARY_PATH=/usr/local/lib /opt/afl/afl-2.52b/afl-fuzz -i testcase_dir -o /opt/proxygen/results -m 200 ./test
