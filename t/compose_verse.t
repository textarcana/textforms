use strict;
use warnings;
use Test::More "no_plan";
use Test::Output;

# debugging mode just nerfs the clear_screen method
$ARGV[0] = 'turn on debugging mode';

require 'lib/Compose_Verse.pm';

# can't do this because $OUT isn't exported
# is($OUT, 'poetry/textforms.txt', 'default location of poetry file');

stdout_is { printer_for_poetry(qw(this is some text)) } "\n\n\n\nthis\nis\nsome\ntext\n\n", 'pretty print a block of text';

# can't do this because method prints to file not screen
# stdout_is { printer_for_titles(false, ) } , 'pretty print titles without time stamp';


=head1

can't test most other methods because they read directly from STDIN
rather than from a data structure

=cut

