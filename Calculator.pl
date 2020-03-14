use strict;
use Parser_Evaluator;
use Getopt::Long;
Getopt::Long::Configure("pass_through");

# Variables to use
my $help_msg = "Usage: perl [options] \"expression\"\n
             Options are:
               --help      displays this message.
               --tests     runs unit tests (Won't solve the expression)\n"; #help message
my $tests = 0; # run unit tests

GetOptions ("help"  => sub{print $help_msg;exit;},
	        "tests" => sub{$tests=1;}
	        );

# Run unit tests.
if ($tests) {
	print `perl -I . Test.pl`;
	exit;
}

my $expr = $ARGV[0];
print Parser_Evaluator::new($expr)->parse_evaluate()->to_string();

1;
