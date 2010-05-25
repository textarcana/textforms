=head1

gate keeper for language

Use a dictionary of words, which I define.  These may be commonly-used
words, which I don't want to over-use, or over-used words, which I no
longer want to mention at all.

=cut

sub common_words_fewer_than {

  my %dict = load_dictionary('lib/dictionary_of_commonly_used_words');

  my $limit = shift;
  my $sentence = shift;
  my $count = 0;

  my @words = split(/ /, $sentence);

  foreach my $token (@words){
    $count++ if (defined $dict{$token});
    }

  if ($count >= $limit){
    return 0;
  }

  return 1;

}

sub forbidden_words_fewer_than {
  my $limit = shift;
  my $sentence = shift;
  my $dict = 'lib/dictionary_of_forbidden_words';

  &reject_line($dict, $limit, $sentence);

}

sub reject_line {

  my %dict = load_dictionary( shift );

  my $limit = shift;
  my $sentence = shift;
  my $count = 0;

  my @words = split(/ /, $sentence);

  foreach my $token (@words){
    $count++ if (defined $dict{$token});
    }

  if ($count >= $limit){
    return 0;
  }

  return 1;

}

=head2 load the dictionary

load a dictionary file and return a hash table

dictionary files are newline-delimited and are assumed to have been uniquified

=cut

sub load_dictionary {

  my $file = shift;

  open(my $IN, $file) or die $!;

  my %dictionary;

  while(<$IN>){
    chomp;
    $dictionary{$_} = 1;

  };

  return %dictionary;

}

1;
