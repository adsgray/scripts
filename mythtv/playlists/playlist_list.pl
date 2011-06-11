#!/usr/bin/perl

use strict;
use warnings;

use DBI;
my $dbh = DBI->connect('DBI:mysql:mythconverg', 'mythtv', 'mythtv'
	           ) || die "Could not connect to database: $DBI::errstr";


sub list_all_playlists
{
	my $sth = $dbh->prepare('SELECT playlist_name FROM music_playlists');
	$sth->execute();

	while (my $row = $sth->fetchrow_arrayref)
	{
		for my $elem (@$row)
		{
			print "$elem\n";
		}
	}
}


sub get_dirname($)
{
	my $dirid = shift;

	my $sth = $dbh->prepare('SELECT path FROM music_directories
			WHERE directory_id = ?');
	$sth->execute($dirid);

	my $dirname = $sth->fetchrow;
	return $dirname;
}

#debug func
sub get_all_dirs
{
	my $dirid = shift;

	my $sth = $dbh->prepare('SELECT path, parent_id FROM music_directories
			WHERE directory_id = ?');

	$sth->execute($dirid);
	my $arrayref = $sth->fetchrow_arrayref;
	return if !defined($arrayref);
	my ($dirname, $pid) = @$arrayref;
	return if !defined($pid);
	print ("$dirname/");
	get_all_dirs($pid);
}

sub list_playlist_songs($)
{
	my $playlist = shift;
	print "# playlist: $playlist\n";

	my $sth = $dbh->prepare('SELECT playlist_songs FROM music_playlists
			WHERE playlist_name = ?');

	$sth->execute($playlist);

	my $songlist = $sth->fetchrow;
	#print "$songlist\n";
	my @songarray = split(/,/,$songlist);

	$sth = $dbh->prepare('SELECT directory_id, filename FROM music_songs 
				WHERE song_id = ?');

	for my $songid (@songarray)
	{
		$sth->execute($songid);
		my $arrayref = $sth->fetchrow_arrayref;
		my ($dirid, $songname) = @$arrayref;
		my $dirname = get_dirname($dirid);
		print "$dirname/$songname\n";
		#print "### ";
		#get_all_dirs($dirid);
		#print "\n";
	}

}

if ($ARGV[0] ne "")
{
	list_playlist_songs($ARGV[0]);
}
else
{
	list_all_playlists;
}





$dbh->disconnect();
