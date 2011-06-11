#!/usr/bin/perl

use strict;
use warnings;

use DBI;
my $dbh = DBI->connect('DBI:mysql:mythconverg', 'mythtv', 'mythtv'
	           ) || die "Could not connect to database: $DBI::errstr";



sub delete_playlist($)
{
	my $plname = shift;

	my $sth = $dbh->prepare('DELETE FROM music_playlists
				WHERE playlist_name = ?');

	$sth->{PrintError} = 1;
	$sth->{RaiseError} = 1;

	$sth->execute($plname) or die "Can't execute SQL statement: $DBI::errstr\n";

}

if ($ARGV[0] ne "")
{
	delete_playlist($ARGV[0]);
}
else
{
	print "must specify playlist to delete\n";
}





$dbh->disconnect();
