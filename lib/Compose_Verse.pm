# set the output directory here

my $OUT = $ENV{POETRY_FILE} || 'poetry/textforms.txt';

# the hideous guts of the verse-assembling engine are hidden below

my $DEBUGGING = $ARGV[0];

# declare variables
my @verse = ();


=head2

Interactively walk the user through the composition of a verse

=cut

sub compose_verse {

  my ($no_stamp, @verse) = @{ legacy_verse_composer(@_) };

  &printer_for_titles($no_stamp);
  &printer_for_poetry(@verse);
}

=head2

print one verse to the log file, or to STDOUT in debugging mode

=cut

sub printer_for_poetry {

    my @verse = @_;

    unless ($DEBUGGING) {

	open OUT, ">>$OUT" or die "Cannot open $OUT for write :$!";

	print OUT join "\n", @verse;
	print OUT "\n";

	&clear_screen;

    } else {
	print "\n\n$form\n\n";
	print  join "\n", @verse;
	print "\n\n";

    }
};


=head2

convoluted logic for querying the user and then rendering a verse
according to rules given in an options hash

=cut

sub legacy_verse_composer {

  # declare variables
  @verse = ();
  my $lines_in_any_verse;
  my $lines_remaining_in_this_verse;

  # process the options hash
  my %options = %{(shift)};
  $form = $options{'form'} if defined  $options{'form'};
  my $longest_line = $options{'longest_line'} if defined $options{'longest_line'};
  my $shortest_line = $options{'shortest_line'} if $options{'shortest_line'};
  my $arbitrary_length = $options{'arbitrary_length'} if $options{'arbitrary_length'};
  my $no_stamp = $options{'no_stamp'} if $options{'no_stamp'};

  # when printing the title, also reset the verse count to 0

  unless ($no_stamp){
    $verse_count = 0;
  }

  ++$verse_count;

  # Subroutine to decide how many lines in the verse
  # Query the user if necessary.
  # NOTE the need to end anonymous perl functions with a semicolon
  my $decide_howmany_lines = sub {

    if ($options{'lines'}) {
      return $options{'lines'};
    } elsif ($arbitrary_length) {
      return &ask_for_int("How many lines?");
    }
  };

  &introduce_verse($form);
  $lines_in_any_verse = $lines_remaining_in_this_verse = &$decide_howmany_lines();

  while ($lines_remaining_in_this_verse > 0) {

    my $current_line = 1 + $lines_in_any_verse - $lines_remaining_in_this_verse;
    my $line = &ask_for_line($current_line);
    --$lines_remaining_in_this_verse;

    # Ensure the longest line is longest
    # TODO Only works reliably if the the first or second line is the longest
    # TODO only checks lines /before/ the longest
    if ($verse[0] && 
        defined $longest_line) {

      if ($current_line == $longest_line) {
        while ((length $line <= length $verse[0])) {
          print STDERR "More words please.\n";
          chomp($line = <STDIN>);
        }
      }

      # Ensure lines that are not the longest line, are shorter
      # TODO only checks lines /after/ the longest
      if ($current_line > $longest_line) {
        while ((length $line >= length $verse[($longest_line - 1)])) {
          print STDERR "Too many words.\n";
          chomp($line = <STDIN>);
        }
      }
    }

    push (@verse, $line);
    &clear_screen;
  }

  return [$no_stamp, @verse];

}


=head2

print a title to the log file

=cut

sub printer_for_titles {

    my $no_stamp = shift;

    open OUT, ">>$OUT" or die "Cannot open $OUT for write :$!";

    unless ($no_stamp) {
	print OUT "\n\n\n\n\n\n$form\n";
	print OUT scalar localtime() . "\n\n";
    };

    print OUT "\n" if $no_stamp;

}

# Clear the screen
# Does nothing in debugging mode
sub clear_screen(){
  unless ($DEBUGGING) {
    system $^O eq 'MSWin32' ? 'cls' : 'clear';
  }
}


# Announc what kind of verse it is
sub introduce_verse {
  my $form = shift;
  &clear_screen;
}

# Prompt the user to enter a number
sub ask_for_int {
  my $prompt = shift;
  my $arbitrary_verse_length;
  while ( ! defined $arbitrary_verse_length || $arbitrary_verse_length <= 0) {
    printf "%s\n", $prompt;
    chomp($arbitrary_verse_length =<STDIN>);
  }
  return $arbitrary_verse_length;
}

# Prompt the user to enter a line of text
sub ask_for_line {

  my $current_line = shift;
  my $line = "";

  my $limit_for_dull_words = 1;

  my $last_line_contained_dull_words = 0;

  until ($line =~ /\w+/ && (forbidden_words_fewer_than($limit_for_dull_words, $line) == 1)) {

    $last_line_contained_dull_words = (forbidden_words_fewer_than($limit_for_dull_words, $line) == 0);

    &clear_screen;

    print "$form.\n";
    printf "%s line", to_ordinal $current_line;
    if ($verse_count > 1) {
      printf " of the %s stanza", to_ordinal $verse_count;
    }
    print ".";

    if ($last_line_contained_dull_words) {
      print  "\nNot enough unusual words. Try again?\n";
    }

    print "\n\n\n\n";


    chomp($line = <STDIN>);
  }

  return $line;

}


1;
