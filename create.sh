#!/bin/sh

rrdtool create monitor.rrd --step 300    \
    DS:output:COUNTER:1800:0:U   \
    DS:input:COUNTER:1800:0:U   \
    RRA:AVERAGE:0.5:1:2016       \
    RRA:HWPREDICT:1440:0.1:0.0035:288

