package Parser_Evaluator;
use strict;
use Fraction;

#print new("1_1/2+1_1/2*1/2")->parse_evaluate()->to_string();

sub new {
	my $expr = shift;
	my $self = bless {expr => $expr};
	return $self;
}

## Methods

#
# Parse and evaluate a single fraction.
#
sub parse_evaluate($) {
	my $self = shift;
	my $expr = $self->{expr};
	if ($expr =~ /^(-?\d*_?\d+\/-?\d+|-?\d+)\+(-?\d*_?\d+\/-?\d+|-?\d+)$/) {
		return $self->evaluate(new($1)->parse_fraction(),new($2)->parse_fraction(),1);
	}
	if ($expr =~ /^(-?\d*_?\d+\/-?\d+|-?\d+)\-(-?\d*_?\d+\/-?\d+|-?\d+)$/) {
		#print "$1........$2";
		return $self->evaluate(new($1)->parse_fraction(),new($2)->parse_fraction(),2);
	}
	if ($expr =~ /^(-?\d*_?\d+\/-?\d+|-?\d+)\*(-?\d*_?\d+\/-?\d+|-?\d+)$/) {
		return $self->evaluate(new($1)->parse_fraction(),new($2)->parse_fraction(),3);
	}
	if ($expr =~ /^(-?\d*_?\d+\/-?\d+|-?\d+)\/(-?\d*_?\d+\/-?\d+|-?\d+)$/) {
		return $self->evaluate(new($1)->parse_fraction(),new($2)->parse_fraction(),4);
	}
	die "Malformed expression.";
}

#
# Parse a single fraction.
#
sub parse_fraction($) {
	my $self = shift;
	my $str = $self->{expr};
	my $num = "";
	my $den = "";
	my $whole = "";
	if ($str =~ /^(-?\d+)\_(-?\d+)\/(-?\d+)$/){ # complete fraction
		$whole = $1;
		$num = $2;
		$den = $3;
	}
	else {
		if ($str =~ /^(-?\d+)\/(-?\d+)$/) { # just fraction part
		$whole = 0;
		$num = $1;
		$den = $2;
		}
		else {
			if ($str =~ /^(-?\d+)$/) { # just whole
				$whole = $1;
				$num = 0;
				$den = 1;
			}
			else {
				die "Malformed fraction.";
			}
		}
	}
	#print "$str\n";
	#print "$whole,$num,$den\n";
	return Fraction::new($whole,$num,$den);
}

	## Evaluate function.

	#
	# This function evaluates an expression.
	#
	sub evaluate ($$$$) {
		my $self = shift;
		my $fract1 = shift;
		my $fract2 = shift;
		my $op = shift;
		return $fract1->add($fract2) if ($op == 1);
		return $fract1->substract($fract2) if ($op == 2);
		return $fract1->multiply($fract2) if ($op == 3);
		return $fract1->divide($fract2) if ($op == 4);
	}
1;
