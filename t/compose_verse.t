use strict;
use warnings;
use Test::More "no_plan";
use Test::Output;

$ARGV[0] = 'turn on debugging mode';

require 'lib/Compose_Verse.pm';

# can't do this because $OUT isn't exported
# is($OUT, 'poetry/textforms.txt', 'default location of poetry file');

# can't do this because printer doesn't return any text
stdout_is { printer_for_poetry('this is some text') } "\n\n\n\nthis is some text\n\n", 'pretty print any string';

