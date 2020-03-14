use strict;
use Test::More;

BEGIN { plan tests => 308}

use Parser_Evaluator;
use Fraction;

print "Tests for the fraction Calculator.\n";

# Simple General tests.
ok(Parser_Evaluator::new("1/2+1/2")->parse_evaluate()->to_string() eq "1","Simple sum");

ok(Parser_Evaluator::new("1/2-1/2")->parse_evaluate()->to_string() eq "0","Simple rest");

ok(Parser_Evaluator::new("1/2*1/2")->parse_evaluate()->to_string() eq "1/4","Simple Multiplication");

ok(Parser_Evaluator::new("1/2/1/2")->parse_evaluate()->to_string() eq "1","Simple Division");

ok(Parser_Evaluator::new("-1/2--3_1/2")->parse_evaluate()->to_string() eq "3","Rest of two negatives");

like(`perl -I . Calculator.pl "-1/-2-3_-1/-2" 2>&1`, qr/Malformed expression/,"Whole part and numerator with minus sign.");

like(`perl -I . Calculator.pl "-1/2-3_1/2+1234/5" 2>&1`, qr/Malformed expression/,"Three operands");

like(`perl -I . Calculator.pl "fails" 2>&1`, qr/Malformed expression/,"Incorrect input");

# Fraction.pm tests, creation and pretty printing of Fractions.Syntax check.
my $frac1;
my $frac2;
for (my $i = 1; $i < 51; $i++) {

  $frac1 = createRandomFraction();
  $frac2 = createRandomFraction();
  like($frac1->to_string(),qr/-?\d+?\_?\d+\/\d+|-?\d+/,"Pretty print, test $i"); #There can only be one minus sign when creating the fraction
  like($frac1->reduce_fraction()->to_string(),qr/-?\d+?\_?\d+\/\d+|-?\d+/,"Pretty print with fraction reduction, test $i"); #Reduction syntax check
  #Operations pretty print syntax check
  like($frac1->add($frac2)->to_string(),qr/-?\d+?\_?\d+\/\d+|-?\d+/,"Pretty print for addition, test $i");
  like($frac1->substract($frac2)->to_string(),qr/-?\d+?\_?\d+\/\d+|-?\d+/,"Pretty print for Substraction, test $i");
  like($frac1->multiply($frac2)->to_string(),qr/-?\d+?\_?\d+\/\d+|-?\d+/,"Pretty print for Multiplication, test $i");
  like($frac1->divide($frac2)->to_string(),qr/-?\d+?\_?\d+\/\d+|-?\d+/,"Pretty print for Division, test $i");
}

#Semantic

#Just whole numbers
ok(`perl -I . Calculator.pl "10+1234" 2>&1` eq "1244","Whole numbers operations, addition.");
ok(`perl -I . Calculator.pl "10-1234" 2>&1` eq "-1224","Whole numbers operations, Substraction.");
ok(`perl -I . Calculator.pl "10*1234" 2>&1` eq "12340","Whole numbers operations, Multiplication.");
ok(`perl -I . Calculator.pl "10/1234" 2>&1` eq "5/617","Whole numbers operations, Division.");

#Whole numbers and fractions with whole part
ok(`perl -I . Calculator.pl "10+1234/3" 2>&1` eq "421_1/3","Whole numbers operations, addition.");
ok(`perl -I . Calculator.pl "10-1234/3" 2>&1` eq "-401_1/3","Whole numbers operations, Substraction.");
ok(`perl -I . Calculator.pl "10*1234/3" 2>&1` eq "4113_1/3","Whole numbers operations, Multiplication.");
ok(`perl -I . Calculator.pl "10/1/1234/3" 2>&1` eq "15/617","Whole numbers operations, Division.");#special case
ok(`perl -I . Calculator.pl "10/6+1234" 2>&1` eq "1235_2/3","Whole numbers operations, addition.");
ok(`perl -I . Calculator.pl "10/6-1234" 2>&1` eq "-1232_1/3","Whole numbers operations, Substraction.");
ok(`perl -I . Calculator.pl "10/6*1234" 2>&1` eq "2056_2/3","Whole numbers operations, Multiplication.");
ok(`perl -I . Calculator.pl "10/6/1234" 2>&1` eq "5/3702","Whole numbers operations, Division.");


ok(`perl -I . Calculator.pl "10+1234" 2>&1` eq "1244","Whole numbers operations, addition.");
ok(`perl -I . Calculator.pl "10-1234" 2>&1` eq "-1224","Whole numbers operations, Substraction.");
ok(`perl -I . Calculator.pl "10*1234" 2>&1` eq "12340","Whole numbers operations, Multiplication.");
ok(`perl -I . Calculator.pl "10/1234" 2>&1` eq "5/617","Whole numbers operations, Division.");
1;
sub createRandomFraction {
  my $num = int(rand(100000));
  my $den = int(rand(100000)) + 1;#can't be zero
  my $whole = int(rand(100000));
  if (rand() < 0.5) {
    $num *= -1;
  }
  if (rand() < 0.5) {
    $whole *= -1;
  }
  if (rand() < 0.5) {
    $num *= -1;
    $whole *= -1;
  }
  if (rand() < 0.85) {
    $den *= -1
  }
  return Fraction::new($whole,$num,$den);
}
