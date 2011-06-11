#!/usr/bin/perl


#TODO: error and stop if dirid or songid cannot be determined

use strict;
use warnings;

use DBI;
use File::Basename;

my $dbh = DBI->connect('DBI:mysql:mythconverg', 'mythtv', 'mythtv'
	           ) || die "Could not connect to database: $DBI::errstr";


#util func
sub printarray($)
{
	my $aref = shift;

	for my $elem (@$aref)
	{
		print "$elem\n";
	}
}



sub get_playlist_id($)
{
	my $playlist_name = shift;
	my $sth = $dbh->prepare('SELECT playlist_id FROM music_playlists
				WHERE playlist_name = ?');
	$sth->execute($playlist_name);

	my $playlist_id = $sth->fetchrow;
	return $playlist_id;
}

sub playlist_exists_p($)
{
	my $pid = get_playlist_id(shift);
	return defined($pid);
}


sub get_dirid($)
{
	my $dirname = shift;

	my $sth = $dbh->prepare('SELECT directory_id FROM music_directories
			WHERE path = ?');
	$sth->execute($dirname);

	my $dirid = $sth->fetchrow;
	return $dirid;
}

# ugly hack, to have this be global
my $songid_sth = $dbh->prepare('SELECT song_id FROM music_songs
				WHERE directory_id = ? AND filename = ?');
sub get_songid($$)
{
	my ($dirname, $songfname) = @_;

	#print "get_songid A: [$dirname][$songfname]\n";
	my $dirid = get_dirid($dirname);
	#print "get_songid B: $dirid\n";
	# todo: error check

	$songid_sth->execute($dirid, $songfname);
	my $songid = $songid_sth->fetchrow;
	return $songid;
}

sub get_playlist_from_file($)
{
	my $fname = shift;
	my $playlist_name = "";
	open my $fh, "<$fname" or die $!;

	my $nameline = <$fh>;
	chomp($nameline);

	if ($nameline =~ /^#\s+playlist:\s+(\w+)/)
	{
		$playlist_name = $1;
	}

	#print "$playlist_name\n";
	my @songids = ();
	while (my $line = <$fh>)
	{
		chomp($line);
		my $dirname = dirname($line);
		my $fname = basename($line);
		#print "[$dirname][$fname]\n";
		my $songid = get_songid($dirname, $fname);
		push @songids, $songid;
		#print "$songid\n";
	}

	my %hash = ( 'name' => $playlist_name, 'songids' => \@songids);
	return \%hash;
}

sub list_playlist_songids($)
{
	my $fname = shift;
	my $plhref = get_playlist_from_file($fname);

	my $plname = $plhref->{'name'};
	my $songids = $plhref->{'songids'};

	print "name: $plname\n";
	printarray($songids);
}

sub create_playlist_from_file($)
{
	my $fname = shift;
	my $plhref = get_playlist_from_file($fname);

	my $plname = $plhref->{'name'};
	my $songids = $plhref->{'songids'};

	my $playlist_songs = join(',',@$songids);
	#print "$playlist_songs\n";

	my $sth;

	if (playlist_exists_p($plname)) {
		print "playlist [$plname] exists. Updating.\n";
		$sth = $dbh->prepare('UPDATE music_playlists
					SET playlist_songs = ?
					WHERE playlist_name = ?');
	}
	else {
		$sth = $dbh->prepare('INSERT INTO music_playlists 
				(playlist_songs, playlist_name) VALUES
				(?,?);');
	}

	$sth->execute($playlist_songs, $plname);
}

if ($ARGV[0] ne "")
{
	#list_playlist_songids($ARGV[0]);
	create_playlist_from_file($ARGV[0]);
}
else
{
	print "must specify filename\n";
}

$songid_sth->finish;
$dbh->disconnect();
