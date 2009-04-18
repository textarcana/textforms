#! /opt/local/bin/perl -w
use strict;
use Lingua::Any::Numbers qw(:std);
# Pantoum
# From Wikipedia, the free encyclopedia
# The pantoum is a form of poetry similar to a villanelle. It is composed of a series of quatrains; 
# the second and fourth lines of each stanza are repeated as the first and third lines of the next...
# except for the final stanza [in which t]he first and third lines... are the second and fourth of the penultimate;
# also, the first line of the poem is the last line of the final stanza,
# and the third line of the first stanza is the second of the final.

# if any arguments are given, input is printed to STDIN instead of the outfile
# my $out = "c:/dropbox/My Dropbox/journal/textforms.txt";
my $DEBUGGING = $ARGV[0];

my $out = $ENV{'DROPBOX_PATH'} . "/journal/textforms.txt";
die "can't find Dropbox: $!" unless -e $out;

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
  print "Poesy template mode: $form\n";
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

  until ($line =~ /\w+/) {
    &clear_screen;
    printf "%s line\n", to_ordinal $current_line;
    chomp($line = <STDIN>);
  }

  return $line;

}

# Interactively walk the user through the composition of a verse
sub compose_verse {

  # declare variables
  my @verse = ();
  my $lines_in_any_verse;
  my $lines_remaining_in_this_verse;

  # process the options hash
  my %options = %{(shift)};
  my $form = $options{'form'};
  my $longest_line = $options{'longest_line'} if defined $options{'longest_line'};
  my $shortest_line = $options{'shortest_line'} if $options{'shortest_line'};
  my $arbitrary_length = $options{'arbitrary_length'} if $options{'arbitrary_length'};

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

        while ( 
               (length $line <= length $verse[0])) {

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

  unless ($DEBUGGING) {

    open OUT, ">>$out" or die "Cannot open $out for write :$!";
    print OUT "\n\n\n\n\n\n$form\n";
    print OUT scalar localtime() . "\n\n";
    print OUT join "\n", @verse;  
    print OUT "\n";
    &clear_screen;

  } else {
    print "\n\n$form\n\n";
    print  join "\n", @verse; 
    print "\n\n";

  }
}

sub compose_couplet{
  my %haiku = (
               lines => 2,
               form => 'Couplet',
              );

  compose_verse(\%haiku);
}

sub compose_haiku{
  my %haiku = (
               lines => 3,
               form => 'Haiku',
               longest_line => 2,
              );

  compose_verse(\%haiku);
}

sub compose_quatrain{
  my %quatrain = (
                  lines => 4,
                  form => 'Quatrain'
                 );

  compose_verse(\%quatrain);
}

sub compose_sonnet{
  my %sonnet = (
                lines => 14,
                form => 'Sonnet'
               );

  compose_verse(\%sonnet);
}

# Concrete poem is a contrived form where no line can be longer than the first
sub compose_concrete{
  my %concrete = (
                  form => 'Concrete Poem',
                  longest_line => 1,
                  arbitrary_length => 'true'
                 );

  compose_verse(\%concrete);
}
;

#Let the user choose what type of poetic form to generate
sub compose_what{
  my $option_id = 0;
  my $selection;
  my @form_titles = qw(
                        couplet
                        haiku
                        quatrain
                        sonnet
                        concrete
                     );
  my @forms = (
               \&compose_couplet,
               \&compose_haiku,
               \&compose_quatrain,
               \&compose_sonnet,
               \&compose_concrete
              );

  &clear_screen;

  foreach my $choice (@form_titles) {

    print "$option_id $choice\n";
    $option_id++;

  }

  print "\nWhat type of poetic form would you like to generate?\n";
  chomp($selection = <STDIN>);
  die "FAIL: You must enter a number corresponding to an option." unless ($form_titles[$selection] ne "");
    
  $forms[$selection]->();

  # in production mode, run forever, C-c to quit
  &compose_what unless $ARGV[0];

}

# MAIN

compose_what;
