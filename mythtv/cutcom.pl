#!/usr/bin/perl

use File::Basename;
#1045_20060710130000.mpg

my $iname=$ARGV[0];
$fname=basename $iname;

if ((! -f $iname) || $fname !~ /(\d{4})_(\d{4})(\d{2})(\d{2})(\d{2})(\d{2})(\d{2})/)
{
	print "invalid filename\n";
	exit;
}

my $chanid = $1;
my $year   = $2;
my $mon    = $3;
my $day    = $4;
my $hour   = $5;
my $min    = $6;
my $aux    = $7;

my $query = "$year-$mon-$day-$hour-$min-$aux";
print "chanid=$chanid query=$query\n";

my $oname = basename $fname, ".mpg";
$oname = "$oname-orig.mpg";

print "fname=$fname\n";
print "origname=$oname\n";

rename $fname, $oname;

#my $cmd="mythcommflag --gencutlist -c $chanid -s $query";
#print "executing $cmd\n";
#system($cmd);
$cmd="mythcommflag --getcutlist -c $chanid -s $query";
print "executing $cmd\n";
system($cmd);
$cmd="time nice -n 25 mythtranscode --mpeg2 -c $chanid -s $query --outfile $fname --honorcutlist --showprogress";
print "executing $cmd\n";
system($cmd);
