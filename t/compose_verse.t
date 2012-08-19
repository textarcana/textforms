use strict;
use warnings;
use Test::More "no_plan";
use Test::Output;

# debugging mode just nerfs the clear_screen method
$ARGV[0] = 'turn on debugging mode';

use Lingua::Any::Numbers qw(:std);
require 'lib/Compose_Verse.pm';

sub forbidden_words_fewer_than {
  return 1;
}

# can't do this because $OUT isn't exported
# is($OUT, 'poetry/textforms.txt', 'default location of poetry file');

stdout_is { printer_for_poetry(qw(this is some text)) } "\n\n\n\nthis\nis\nsome\ntext\n\n", 'pretty print a block of text';

# can't do this because method prints to file not screen
# stdout_is { printer_for_titles(false, ) } , 'pretty print titles without time stamp';

# data provider with fake STDIN values, see
# http://stackoverflow.com/questions/1213986
my $fake_inputs = qq{come and get this cat
this cat is of doom
&#?!%
it is an evil cat
this line is boring
but this one is interesting again
};

open my $stdin, '<', \ $fake_inputs
  or die "Cannot open STDIN to read from string: $!";
local *STDIN = $stdin;

stdout_is { ask_for_line('1') } ".\nfirst line.\n\n\n\n",
  'prompts for a line and get a good line of input';

is(&ask_for_line('1'),
   'this cat is of doom',
   'prompts for a line and returns the input');

stdout_is { ask_for_line('3') } ".\nthird line.\n\n\n\n.\nthird line.\n\n\n\n",
  'upon getting a bad input, keep prompting until we get a good input';

# my $counter = -1;

# { no warnings 'redefine';

#   sub forbidden_words_fewer_than {
#     return $counter += 1;
#   }

# stdout_is { ask_for_line('4') } ".\nfourth line.\n\n\n\n",
#   'upon getting a bad input, keep prompting until we get a good input';
  
# }

