#!/usr/bin/perl

my $DIR="/home/agray/.procmail/config";
my $SPAMFOLDER="./SPAM";

my $date = localtime;
print "# generated by makerc.pl $date\n";

sub do_list
{
	my $infile = shift;
	my $first = 1;
	my $out = "";

	open(INF, "<$infile");
	while (my $line = <INF>)
	{
		chomp($line);
		next if ($line eq "" || $line =~ /^#/);
		$out .= "|" if (!$first);
		$out .= $line;
		$first = 0;
	}
	close(INF);

	return $out;
}

sub do_whiteheaders
{
	my $infile = shift;
	my $out = "";

	open(INF, "<$infile");
	while (my $line = <INF>)
	{
		chomp($line);
		next if ($line eq "" || $line =~ /^#/);
		$out .= "* !$line\n";
	}
	close(INF);
	return $out;
}

sub do_cat
{
	my ($inf, $prefix) = @_;
	open(INF, "<$inf");
	while (my $line = <INF>)
	{
		print "$prefix$line";
	}
	close(INF);
}

sub do_lists
{
	my ($inf, $title) = @_;
	return if (! -f $inf);

	print <<EOF;
###############################
# BEGIN: $title
###############################
EOF
	open(INF, "<$inf");
	while (my $line = <INF>)
	{
		chomp($line);
		next if ($line eq "" || $line =~ /^#/);
		my ($rules, $folder) = split /=/, $line, 2;
		my @rules = split /;/, $rules;
		print ":0:\n";
		for my $rule (@rules)
		{
			print "* $rule\n";
		}
		print "./$folder\n\n";
	}
	close(INF);
	print <<EOF;
###############################
# DONE: $title
###############################


EOF
}

#################################
# main:
#################################

do_cat "$DIR/generic.base";
do_lists "$DIR/lists", "mailing lists";

print <<EOF;
################################
#  SPAM FILTERING HEURISTICS   #
################################
EOF

if (-f "$DIR/blacklist")
{
	print <<EOF;
# blacklist. emails from these addresses are SPAM.
:0:
EOF
	print "* ^From:.*(";
	print do_list "$DIR/blacklist";
	print ")\n$SPAMFOLDER\n\n";
}

if (-f "$DIR/whitelist")
{
	print <<EOF;
# SPAM rules wrapped in whitelist. emails from these addresses are *not* SPAM.
:0
EOF
	print "* !^From:.*(";
	print do_list "$DIR/whitelist";
	print ")\n";
	print do_whiteheaders "$DIR/whiteheaders";
	print "{\n";
}

#do_cat "$DIR/reply_to_scammer.rule", "\t";

print <<EOF;
	# If it's not TO one of my email addresses, it is SPAM.
	:0:
EOF
print "\t* !^TO_.*(";
print do_list "$DIR/myaddresses";
print ")\n\t$SPAMFOLDER\n\n";

print <<EOF;
	# If it is TO one of my email addresses, but not TO andrew gray, it is SPAM.
	:0:
EOF
print "\t* !^TO_.*(";
print do_list "$DIR/mynames";
print ")\n\t$SPAMFOLDER\n\n";

print <<EOF;
	# subject lines
	:0:
EOF
print "\t* ^Subject:.*(";
print do_list "$DIR/badsubjects";
print ")\n\t$SPAMFOLDER\n}\n";


do_lists "$DIR/aliases", "aliases";
