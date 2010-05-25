use strict;
use Test::More "no_plan";

use Data::Dumper;

require 'lib/Forbidden_Words.pm';

my %d = load_dictionary('lib/dictionary_of_forbidden_words');

isa_ok(\%d, 'HASH', 'load dictionary from file');

is($d{'idealize'}, 1, 'known forbidden word has an entry');

is(forbidden_words_fewer_than(1, 'idealize ideal'), 0, 'detect too many forbidden words per line');

is(forbidden_words_fewer_than(3, 'idealize ideal'), 1, 'allow a reasonable number of forbidden words per line')

