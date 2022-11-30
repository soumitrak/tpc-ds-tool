#!/bin/bash

SCALE=$1
OUTPUT_DIR=$2

for i in {1..99}; do
    num=`printf "%02d\n" $i`
    ./dsqgen -template query$i.tpl -directory ../query_templates -dialect netezza -scale $SCALE -OUTPUT_DIR $OUTPUT_DIR
    mv $OUTPUT_DIR/query_0.sql $OUTPUT_DIR/query$num.sql
done

