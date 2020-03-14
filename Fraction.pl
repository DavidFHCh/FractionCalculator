package Fraction;
use strict;
use POSIX;

############################################################
# Examples
# print to_string(new(0,$x,$y)->add(new(0,$x,$y)));
# print to_string(new(0,$x,$y)->substract(new(0,$x,$y)));
# print to_string(new(0,$x,$y)->multiply(new(0,$x,$y)));
# print to_string(new(0,$x,$y)->divide(new(0,$x,$y)));
############################################################

#
# Fraction constructor.
#
sub new  {
  my ($whole,$num,$den) = @_;
  die "Denominator can't be 0" if ($den == 0);
  my $self = bless {
    whole => $whole,
    num   => $num,
    den   => $den,
  };
  return $self;
}

## Operation Methods.

#
# Addition operation.
#
sub add ($$) {
  my $fract1 = shift;
  my $fract2 = shift;
  $fract1->make_improper_fraction();
  $fract2->make_improper_fraction();
  my $lcd = lcd($fract1->{den},$fract2->{den});
  my $op1 = $fract1->obtain_numerator_op($lcd);
  my $op2 = $fract2->obtain_numerator_op($lcd);
  return new(0,$op1+$op2,$lcd)->reduce_fraction();
}

#
# Substraction operation.
#
sub substract ($$) {
  my $fract1 = shift;
  my $fract2 = shift;
  $fract1->make_improper_fraction();
  $fract2->make_improper_fraction();
  my $lcd = lcd($fract1->{den},$fract2->{den});
  my $op1 = $fract1->obtain_numerator_op($lcd);
  my $op2 = $fract2->obtain_numerator_op($lcd);
  return new(0,$op1-$op2,$lcd)->reduce_fraction();
}

#
# Multiplication operation.
#
sub multiply ($$) {
  my $fract1 = shift;
  my $fract2 = shift;
  $fract1->make_improper_fraction();
  $fract2->make_improper_fraction();
  my $fract1_num = $fract1->{num};
  my $fract1_den = $fract1->{den};
  my $fract2_num = $fract2->{num};
  my $fract2_den = $fract2->{den};
  return new(0,$fract1_num*$fract2_num,$fract1_den*$fract2_den)->reduce_fraction();
}

#
# Division operation.
#
sub divide ($$) {
  my $fract1 = shift;
  my $fract2 = shift;
  $fract1->make_improper_fraction();
  $fract2->make_improper_fraction();
  my $fract1_num = $fract1->{num};
  my $fract1_den = $fract1->{den};
  my $fract2_num = $fract2->{num};
  my $fract2_den = $fract2->{den};
  return new(0,$fract1_num*$fract2_den,$fract1_den*$fract2_num)->reduce_fraction();
}

## Auxuliary methods

#
# Transform to improper fraction.
#
sub make_improper_fraction ($) {
  my $self = shift;
  my $num = $self->{num};
  my $den = $self->{den};
  my $whole = $self->{whole};
  $self->{num} = $num + ($whole * $den);
  $self->{whole} = 0; 
}

#
# Reduce fraction to lowest form.
#
sub reduce_fraction($) {
  my $self = shift;
  my $num = $self->{num};
  my $den = $self->{den};
  my $whole = $self->{whole};
  if ($num >= $den) {
    $whole += floor($num/$den);
    $num = $num%$den;
  }
  my $gcd = gcd ($num,$den);
  $self->{num} = $num/$gcd;
  $self->{den} = $den/$gcd;
  $self->{whole} = $whole;
  return $self;
}

#
# Obtain the numerator for an operation(+/-).
#
sub obtain_numerator_op($$) {
  my $self = shift;
  my $lcd = shift;
  my $num = $self->{num};
  my $den = $self->{den};
  return ($lcd*$num/$den);
}

#
# Print object in a human readable way.
#
sub to_string ($) {
  my $self = shift;
  my $num = $self->{num};
  my $den = $self->{den};
  my $whole = $self->{whole};
  my $fract = "";
  return "$whole\n" if ($num == 0);
  $whole = "" if ($whole == 0);
  $whole .= "_" if ($whole != 0);
  $fract = "$num/$den";
  return "$whole$fract\n";
}

## Numeric functions

#
# Greatest common divisor of two numbers.
#
sub gcd($$) {
  my $a = shift;
  my $b = shift;

  return $b if ($a == 0);
  return gcd($b % $a,$a);
}

#
# Least common divisor of two numbers.
#
sub lcd($$) {
  my $a = shift;
  my $b = shift;
  return $a * $b / gcd($a,$b);
}