#!/usr/bin/perl


# exclude names that start with '.' and that don't end with a media extension
while (my $line = <>)
{
	chomp($line);
	if ($line =~ /(^\.\/)(.*)\/(.*)/)
	{
		my $dir = $2;
		my $fname = $3;
		print "$dir/$fname\n" 
			if ($fname =~ /^[^\.].*(mp3|m4a|ogg|wma)$/i)
	}
}
