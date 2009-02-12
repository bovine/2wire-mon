#!/bin/sh

RRDFILE=monitor.rrd
IMAGEFILE3=~/public_html/2wire/2wire3.png
IMAGEFILE14=~/public_html/2wire/2wire14.png

if [ ! -f $RRDFILE ]; then
    echo "Could not access $RRDFILE"
    exit 1
fi


DAYCOLOR="#66aa66"

rrdtool graph $IMAGEFILE3 \
    -A -w600 -h480 --imgformat=PNG \
    --title="Cowhouse Bandwidth (last 3 days) ... $(date)" \
    --vertical-label="Bytes/sec" \
    --start="-3 day" \
    --slope-mode \
    --alt-autoscale-max \
    DEF:input=$RRDFILE:input:AVERAGE \
    DEF:output=$RRDFILE:output:AVERAGE \
    LINE1:input#ff0000:"download" \
    LINE1:output#0000ff:"upload" \
    VRULE:$(date -d 'today 0:00' +%s)$DAYCOLOR \
    VRULE:$(date -d '-1 day 0:00' +%s)$DAYCOLOR \
    VRULE:$(date -d '-2 day 0:00' +%s)$DAYCOLOR \
    VRULE:$(date -d '-3 day 0:00' +%s)$DAYCOLOR \
    COMMENT:"\\l" >/dev/null



rrdtool graph $IMAGEFILE14 \
    -A -w600 -h480 --imgformat=PNG \
    --title="Cowhouse Bandwidth (last 14 days) ... $(date)" \
    --vertical-label="Bytes/sec" \
    --start="-14 day" \
    --slope-mode \
    --alt-autoscale-max \
    --x-grid HOUR:8:DAY:1:DAY:1:0:"%a%d" \
    DEF:input=$RRDFILE:input:AVERAGE \
    DEF:output=$RRDFILE:output:AVERAGE \
    LINE1:input#ff0000:"download" \
    LINE1:output#0000ff:"upload" \
    VRULE:$(date -d 'today 0:00' +%s)$DAYCOLOR \
    VRULE:$(date -d '-1 day 0:00' +%s)$DAYCOLOR \
    VRULE:$(date -d '-2 day 0:00' +%s)$DAYCOLOR \
    VRULE:$(date -d '-3 day 0:00' +%s)$DAYCOLOR \
    VRULE:$(date -d '-4 day 0:00' +%s)$DAYCOLOR \
    VRULE:$(date -d '-5 day 0:00' +%s)$DAYCOLOR \
    VRULE:$(date -d '-6 day 0:00' +%s)$DAYCOLOR \
    VRULE:$(date -d '-7 day 0:00' +%s)$DAYCOLOR \
    VRULE:$(date -d '-8 day 0:00' +%s)$DAYCOLOR \
    VRULE:$(date -d '-9 day 0:00' +%s)$DAYCOLOR \
    VRULE:$(date -d '-10 day 0:00' +%s)$DAYCOLOR \
    VRULE:$(date -d '-11 day 0:00' +%s)$DAYCOLOR \
    VRULE:$(date -d '-12 day 0:00' +%s)$DAYCOLOR \
    VRULE:$(date -d '-13 day 0:00' +%s)$DAYCOLOR \
    VRULE:$(date -d '-14 day 0:00' +%s)$DAYCOLOR \
    COMMENT:"\\l" > /dev/null

# If SELinux is in use, then you may need to authorize the generated
# images to be readable by your webserver.
#chcon -t httpd_sys_content_t $IMAGEFILE3 $IMAGEFILE14


exit 0

