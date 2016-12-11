use v6;
use lib 'lib';
use Test;
use FileSystem::Capacity::VolumesInfo;
use FileSystem::Capacity::DirSize;

plan 3;

subtest {

	# byte version	
	my %vols = volumes-info();

	for %vols.sort(*.key)>>.kv -> ($location, $data) {
	  like $location, /^.+/, "Location have a character or more";
	  ok ($data<size> > 0), "Size > 0";
	  ok ($data<used> >= 0), "Used >= 0";
	  like $data<used%>, /^\d ** 1..2\%/, "Used% is a percent";
	  ok ($data<free> >= 0), "Free >= 0";
	}
}

subtest {

	# human version	
	my %vols-human = volumes-info(:human);

	for %vols-human.sort(*.key)>>.kv -> ($location, $data) {
	  like $location, /^.+/, "Location have a character or more";
	  like $data<size>,  /^0\sBytes || \d+\.\d ** 1..2\s\w ** 2..5/, "Size is 0 or decimal, space and suffix";
	  like $data<used>,  /^0\sBytes || \d+\.\d ** 1..2\s\w ** 2..5/, "Used is 0 or decimal, space and suffix";
	  like $data<used%>, /^\d ** 1..2\%/, "Used% is a percent";
	  like $data<free>,  /^0\sBytes || \d+\.\d ** 1..2\s\w ** 2..5/, "Free is 0 or decimal, space and suffix";
	}
}

subtest {

	# dirsize, byte and human version	
	my $dir;

	given $*KERNEL {
	  when /linux/ { $dir = '/bin' }
	  when /win32/ { $dir = 'c:\windows' }
	}

	ok ( dirsize($dir) >= 0 ), "Size >= 0";
	like dirsize($dir, :human), /^0\sBytes || \d+\.\d ** 1..2\s\w ** 2..5/, "Size is 0 or decimal, space and suffix";
}