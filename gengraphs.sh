#!/bin/sh

RRDFILE=monitor.rrd

IMAGEFILE1=~/public_html/2wire/2wire1.png
IMAGEFILE3=~/public_html/2wire/2wire3.png
IMAGEFILE14=~/public_html/2wire/2wire14.png
IMAGEFILE30=~/public_html/2wire/2wire30.png
IMAGEFILE365=~/public_html/2wire/2wire365.png


if [ ! -f $RRDFILE ]; then
    echo "Could not access $RRDFILE"
    exit 1
fi


LABELTEXT="Cowhouse Bandwidth"
DAYCOLOR="#66aa66"


rrdtool graph $IMAGEFILE1 \
    -A -w600 -h480 --imgformat=PNG \
    --title="$LABELTEXT (last 24 hours) ... $(date)" \
    --vertical-label="Bytes/sec" \
    --start="-1 day" \
    --slope-mode \
    --alt-autoscale-max \
    --x-grid MINUTE:15:HOUR:1:HOUR:3:0:"%X" \
    DEF:input=$RRDFILE:input:AVERAGE \
    DEF:output=$RRDFILE:output:AVERAGE \
    LINE1:input#ff0000:"download" \
    LINE1:output#0000ff:"upload" \
    VRULE:$(date -d 'today 0:00' +%s)$DAYCOLOR \
    COMMENT:"\\l" >/dev/null


rrdtool graph $IMAGEFILE3 \
    -A -w600 -h480 --imgformat=PNG \
    --title="$LABELTEXT (last 3 days) ... $(date)" \
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
    --title="$LABELTEXT (last 14 days) ... $(date)" \
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


rrdtool graph $IMAGEFILE30 \
    -A -w640 -h480 --imgformat=PNG \
    --title="$LABELTEXT (last 30 days) ... $(date)" \
    --vertical-label="Bytes/sec" \
    --start="-30 day" \
    --slope-mode \
    --alt-autoscale-max \
    --x-grid DAY:1:WEEK:1:WEEK:1:0:"%D" \
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
    VRULE:$(date -d '-15 day 0:00' +%s)$DAYCOLOR \
    VRULE:$(date -d '-16 day 0:00' +%s)$DAYCOLOR \
    VRULE:$(date -d '-17 day 0:00' +%s)$DAYCOLOR \
    VRULE:$(date -d '-18 day 0:00' +%s)$DAYCOLOR \
    VRULE:$(date -d '-19 day 0:00' +%s)$DAYCOLOR \
    VRULE:$(date -d '-20 day 0:00' +%s)$DAYCOLOR \
    VRULE:$(date -d '-21 day 0:00' +%s)$DAYCOLOR \
    VRULE:$(date -d '-22 day 0:00' +%s)$DAYCOLOR \
    VRULE:$(date -d '-23 day 0:00' +%s)$DAYCOLOR \
    VRULE:$(date -d '-24 day 0:00' +%s)$DAYCOLOR \
    VRULE:$(date -d '-25 day 0:00' +%s)$DAYCOLOR \
    VRULE:$(date -d '-26 day 0:00' +%s)$DAYCOLOR \
    VRULE:$(date -d '-27 day 0:00' +%s)$DAYCOLOR \
    VRULE:$(date -d '-28 day 0:00' +%s)$DAYCOLOR \
    VRULE:$(date -d '-29 day 0:00' +%s)$DAYCOLOR \
    VRULE:$(date -d '-30 day 0:00' +%s)$DAYCOLOR \
    COMMENT:"\\l" > /dev/null

 

rrdtool graph $IMAGEFILE365 \
    -A -w640 -h480 --imgformat=PNG \
    --title="$LABELTEXT (last year) ... $(date)" \
    --vertical-label="Bytes/sec" \
    --start="-365 day" \
    --slope-mode \
    --alt-autoscale-max \
    --x-grid YEAR:1:MONTH:1:MONTH:1:0:"%b" \
    DEF:input=$RRDFILE:input:AVERAGE \
    DEF:output=$RRDFILE:output:AVERAGE \
    LINE1:input#ff0000:"download" \
    LINE1:output#0000ff:"upload" \
    COMMENT:"\\l" > /dev/null


# If SELinux is in use, then you may need to authorize the generated
# images to be readable by your webserver.
#chcon -t httpd_sys_content_t $IMAGEFILE3 $IMAGEFILE14


exit 0

