#!/usr/bin/perl

# Program # : Program No. 7
# Colleagues: NONE
# Takes a student id to find it in the logins record kept by loki. It returns the id's 
# time that its being active during the current month and returns the number of logs

use Modern::Perl;

my $nuid = 0;
if($ARGV[0]) { $nuid = $ARGV[0]; }
my $nuid_cut = substr ($nuid, 0, 8);
my @month_logs = `last`; 
my $nuid_logins = 0;
my $day = 0;
my $hrs = 0;
my $mins = 0;

#if( !($nuid =~ m/.{8}/)  || $ARGV[1]) {
if( !($ARGV[0]) || $ARGV[1]) {
    say qq'\n-bash: '.$0.' : No such file or directory';
    say qq'usage: \n\tperl -w '.$0.qq' an_argument\n';
} else {
    print qq'Here is a listing of the logins for '.$nuid.q':'; 
    foreach my $row_log (@month_logs) {
        if($row_log =~ m/\b$nuid_cut\b/) {
            if($nuid_logins == 0) { print qq'\n\n'; };
            print qq'\t'.++$nuid_logins.".\t".$row_log;
            my ($d) = ($row_log =~ /\(\b(\d)\+\b/);
            my ($h, $m) = ($row_log =~ /\S\b(\d\d)\:(\d\d)\b\S/);
            ($d) = 0 if !$d;
            ($h, $m) = (0,0) if !$m;
            $day += $d;
            $hrs += $h; 
            $mins += $m;
        }
    }
    $hrs += $day*24 + $mins/60;
    $mins %= 60;

    print qq'\nHere is a summary of the time spent on the system for '.$nuid.qq':\n';

    print qq'\n'.$nuid;
    print qq'\n'.$nuid_logins;
    printf qq'\n%02d:%02d\n\n', $hrs, $mins;
}
