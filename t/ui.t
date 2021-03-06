use strict;
use warnings;
use Test::More "no_plan";
use Test::Output;

require 'lib/UI.pm';

# debug mode prevents running in an endless loop
$ARGV[0] = 'turn on debugging mode';

my %called_ok = (
                 clear_screen => 0,
                 pantoum => 0,
                 compose_couplet => 0
                );

sub clear_screen {
  $called_ok{clear_screen} += 1;
}

sub pantoum {
  $called_ok{pantoum} += 1;
}

sub compose_couplet {
  $called_ok{compose_couplet} += 1;
}


# data provider with fake STDIN values, see
# http://stackoverflow.com/questions/1213986
my $fake_inputs = qq{0
                     10
                     11
};

open my $stdin, '<', \ $fake_inputs
  or die "Cannot open STDIN to read from string: $!";
local *STDIN = $stdin;

# each time start_command_shell is invoked, it unshifts a fake input
# off of the stack and applies that input to STDIN as if it had been
# entered by a user at the keyboard

is(&start_command_shell, "turn on debugging mode", "user chooses to generate a couplet");
is($called_ok{compose_couplet}, 1, "couplet generator was called");
is($called_ok{clear_screen}, 1, "clear_screen was called exactly once so far");

is(&start_command_shell, "turn on debugging mode", "user chooses to generate a pantoum");
is($called_ok{pantoum}, 1, "pantoum generator was called");
is($called_ok{clear_screen}, 2, "clear_screen was called exactly twice so far");

eval{ &start_command_shell };

is($@,
   "FAIL: You must enter a number corresponding to an option. at lib/UI.pm line 49, <STDIN> line 3.\n",
   "prompt the user to choose a type of poem to generate");

is($called_ok{clear_screen}, 3, "clear_screen was called exactly three times so far");

