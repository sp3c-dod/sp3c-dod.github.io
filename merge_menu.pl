#!C:\Perl\bin\perl.exe -w

opendir(DIRFILENAMES, ".");
my @filenames = readdir(DIRFILENAMES);
closedir(DIRFILENAMES);

open (FTPSCRIPT, ">ftpscript.txt");
print FTPSCRIPT "open golf.xplaid.net\n";
print FTPSCRIPT "billkamm\n";
print FTPSCRIPT "ila3243\n";
print FTPSCRIPT "ascii\n";

foreach (@filenames)
{
if(($_ =~ m/.*html/) && ($_ ne 'menu.html') && ($_ ne 'infoline.html'))
{

	my $looping = 0;

	print FTPSCRIPT "put C:\\Docume~1\\Owner\\MyDocu~1\\billkamm.net\\root\\sp3c\\$_ /usr/home/billkamm/html/sp3c/$_\n";

	open (ORIGINAL, "<$_");
	my @lines = <ORIGINAL>;
	close (ORIGINAL);
	open (MENUFILE, "<menu.html");
	my @menulines = <MENUFILE>;
	close (MENUFILE);
	open (INFOLINEFILE, "<infoline.html");
	my @infolines = <INFOLINEFILE>;
	close (INFOLINEFILE);

	open (NEWFILE, ">$_");

	foreach (@lines) {
		if ($looping == 1) {
			if (($_ eq "<!-- END MENU -->\n") || ($_ eq "<!-- END AFFLIATES -->\n")) {
				$looping = 0;
			}
			next;
		}

		if ($_ eq "<!-- MENU -->\n") {
			print NEWFILE "<!-- MENU -->\n";
			foreach (@menulines) {
				print NEWFILE $_;
			}
			print NEWFILE "<!-- END MENU -->\n";
			$looping = 1;
		}
		elsif ($_ eq "<!-- AFFLIATES -->\n") {
			print NEWFILE "<!-- AFFLIATES -->\n";
			foreach (@infolines) {
				print NEWFILE $_;
			}
			print NEWFILE "<!-- END AFFLIATES -->\n";
			$looping = 1;
		}
		else {
			print NEWFILE $_;
		}
	}

	close(NEWFILE);
}
}

print FTPSCRIPT "close\n";
Close(FTPSCRIPT);