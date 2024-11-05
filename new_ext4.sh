#!/bin/sh
DIR=/home/feng/test/ext4/postsql/
new_psql -f /home/feng/test/ext4/postsql/t.sql --echo-all test
