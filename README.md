# FractionCalculator

Usage:
perl -I . Calculator.pl [options] "expression"

Where options can be:
    ⋅⋅*-t  runs the tests.
    ⋅⋅*-h  displays a help message

The expressions must be of the form:
    ⋅⋅*-x_y/z
    ⋅⋅*-y/z
    ⋅⋅*-y
  where x,y,z are integers.

  The supported operations are "+","-","*","/".

  Examples:

  perl -I . Calculator.pl "1/2+3/4"

  perl -I . Calculator.pl "1/2-3/4"

  perl -I . Calculator.pl "1/2*3/4"

  perl -I . Calculator.pl "1/2/3/4"

This calculator can only operate with two fractions or two whole numbers.
