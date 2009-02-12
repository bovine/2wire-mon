#!/usr/bin/perl

use strict;
use LWP::UserAgent;
use RRDs;

use constant HOMEPORTAL_URL => 'http://homeportal.gateway.2wire.net/xslt';
use constant ADMIN_PASSWORD => 'zse4rfv123';
use constant RRD_FILENAME => "monitor.rrd";


my $ua = LWP::UserAgent->new;
$ua->timeout(10);
push @{ $ua->requests_redirectable }, 'POST';


my %params = ( 'PAGE' => 'A02_POST',
               'NEXTPAGE' => 'J03',
               'PASSWORD' => ADMIN_PASSWORD
    );
my $response = $ua->post(HOMEPORTAL_URL, \%params);

my %stats;
if ($response->is_success) {
    my $html = $response->content;
    die if $html !~ m|<title>2WIRE MDC - Broadband Link Statistics</title>|;
    $html =~ s/^.*?<div class="mdcpagetitlebar">//s
        or die "failed to find mdcpagetitlebar";
    $html =~ s/^.*?<td colspan="10" class="mdcdotted">//s
        or die "failed to find mdcdotted";
    my @headings;
    while ($html =~ m|<tr>(.*?)</tr>|gs) {
        my $htmlrow = $1;
        my @columns;
        while ($htmlrow =~ m|<td.*?>(.*?)</td>|gs) {
            push(@columns, $1);
        };
        if (!scalar(@headings)) {
            @headings = @columns;
        } else {
            my $name = $columns[0];
            for (my $i = 1; $i < scalar(@columns); $i++) {
                next if !length($columns[$i]);
                $stats{$name}{$headings[$i]} = $columns[$i];
            }
        }
    }
}
else {
    die $response->status_line;
}

#print Dumper(\%stats);
#print "Transmit: " . $stats{'Transmit:'}{'Bytes'} . "\n";
#print "Receive: " . $stats{'Receive:'}{'Bytes'} . "\n";


# If the RRD does not already exist, create it.
if (! -f RRD_FILENAME) {
    warn "Existing RRD not found; initializing new RRD file: @{[ RRD_FILENAME ]} ...\n";
    RRDs::create( RRD_FILENAME, "--step", "300",
                  "DS:output:COUNTER:1800:0:U",
                  "DS:input:COUNTER:1800:0:U",
                  "RRA:AVERAGE:0.5:1:2016",
                  "RRA:HWPREDICT:1440:0.1:0.0035:288" )
        or die "Failed to create RRD";
    warn "Successfully created new RRD.\n";
}

# Save to RRD database.
RRDs::update (RRD_FILENAME, "--template", "input:output",
              "N:" . $stats{'Receive:'}{'Bytes'} .
              ':' . $stats{'Transmit:'}{'Bytes'})
    or warn "Failed to update RRD";

exit 0;
