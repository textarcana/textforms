use strict;
use Test::More "no_plan";

use Data::Dumper;

require 'lib/Gate_Keeper.pm';

my %d = load_dictionary('lib/dictionary_of_commonly_used_words');

isa_ok(\%d, 'HASH', 'load dictionary from file');

is($d{'abandoning'}, 1, 'known common word has an entry');

is(common_words_fewer_than(2, 'abandoning ability able'), 0, 'detect too many common words');

is(common_words_fewer_than(2, 'abandoning '), 1, 'allow a reasonable number of common words per line');

is(forbidden_words_fewer_than(1, 'idealize ideal'), 0, 'detect too many forbidden words per line');

is(forbidden_words_fewer_than(3, 'idealize ideal'), 1, 'allow a reasonable number of forbidden words per line')

