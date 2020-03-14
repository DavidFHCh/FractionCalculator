package Parser_Evaluator;
use strict;
use Fraction;

new("1")->parse_fraction();

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
	if ($expr =~ /(\d*_?\d+\/\d+)\+(\d*_?\d+\/\d+)/) {
 		
	}
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
	if ($str =~ /(\d*)_?(\d+)\/(\d+)|(\d+)/) {
		if ($2 == " ") {
			# Create fraction only with whole part.
			$whole = $4;
			$num = 0;
			$den = 1;
		}
		else {
			$whole = $1;
			$num = $2;
			$den = $3;
			$whole = 0 if ($whole == " ");
		}
		} else {
			die "Malformed expression.";
		}
		return Fraction::new($whole,$num,$den);
	}

	## Evaluate function.

	#
	# This function evaluates an expression.
	#
	sub evaluate ($$$) {
		my $fract1 = shift;
		my $fract2 = shift;
		my $op = shift;
		return $fract1->add($fract2) if ($op == 1);
		return $fract1->substract($fract2) if ($op == 2);
		return $fract1->multiply($fract2) if ($op == 3);
		return $fract1->divide($fract2) if ($op == 4);
	}