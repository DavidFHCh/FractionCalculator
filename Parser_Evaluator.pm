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
	if ($expr =~ /^(-?\d*_?-?\d+\/-?\d+|-?\d+)$/) {
		return new($1)->parse_fraction();
	}
	if ($expr =~ /^(.+)\+(.+)$/) {
		return $self->evaluate(new($1)->parse_evaluate(),new($2)->parse_evaluate(),1);
	}
	if ($expr =~ /^(.+)\-(.+)$/) {
		return $self->evaluate(new($1)->parse_evaluate(),new($2)->parse_evaluate(),2);
	}
	if ($expr =~ /^(-?\d*_?-?\d+\/-?\d+|-?\d+)\*(.+)$/) {
		return $self->evaluate(new($1)->parse_evaluate(),new($2)->parse_evaluate(),3);
	}
	if ($expr =~ /^(-?\d*_?-?\d+\/-?\d+|-?\d+)\/(.+)$/) {
		return $self->evaluate(new($1)->parse_evaluate(),new($2)->parse_evaluate(),4);
	}
	die ("Malformed expression.");
}

#
# Parse a single fraction. CORREGIR
#
sub parse_fraction($) {
	my $self = shift;
	my $str = $self->{expr};
	my $num = "";
	my $den = "";
	my $whole = "";
	if ($str =~ /^(.+)\/(.+)/$/ {
    if ($1 =~ /^(-?\d+)\_(-?\d+)/$/) {
			$num = $2;
			$whole = $1;
		}
		if ($2 =~ /^(-?\d+)$/) {
      $den = $1;
		}
	} else {
		if ($str =~ /^(-?\d+)$/) {
				$whole = $1;
		}
		else {
			die "Malformed expression.";
		}
  }
	print ($whole,$num,$den);
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
