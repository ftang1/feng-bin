#!/bin/sh
DIR=/home/feng/test/ext4/postsql/
psql -f t.sql --echo-all test
