
use Fraction;
use Parser;
use Getopt::Long;

# Variables to use
$help_msg = "Usage: perl [options] \"expression\"\n
             Options are: 
               --help      displays this message.
               --tests     runs unit tests (Won't solve the expression)\n"; #help message
$tests = 0; # run unit tests

GetOptions ("help"  => sub{print $help_msg;exit;},
	        "tests" => sub{$tests=1;}
	        ) or die ($help_msg);

# Run unit tests.
if ($tests) {
	#TODO tests.
	exit;
}