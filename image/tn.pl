#!/usr/bin/perl


if (! -d "tn") {
	mkdir "tn",0755;
}

opendir(DIR, ".");
open(FL,">index.html");

print FL qq(<html>
<head><title>images</title>
<style type="text/css">
body {
	background-color: #000000;
}

div {
	float: left;
	margin: 10px 10px 10px 10px;
	background-color: #DDDDDD;
	padding: 10px 5px 5px 5px;
}

div img {
	display: block;
	margin-left: auto;
	margin-right: auto;
}

</style>
</head>
<body>
);

my @files = readdir(DIR);
closedir(DIR);

#while (my $fname = readdir(DIR))
for my $fname (sort(@files))
{
	if ($fname =~ /JPG$/i)
	{
		print "processing $fname...\n";
		if (! -f "tn/$fname") {
			my $cmd = qq(jhead -st "tn/$fname" $fname);
			system $cmd;
		}
		my $cmd = qq(jhead -exifmap $fname|grep Date);
		#my $date = `$cmd`;
		#	$date 
			#<br/>
		print FL qq(
			<div>
			<a href="$fname">
			<img src="tn/$fname" border="0"></a>
			</div>
			\n);
	}
}

print FL qq(</body>
</html>
);

close(FL);
