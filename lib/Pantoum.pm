#! /opt/local/bin/perl -w
use strict;
use Lingua::Any::Numbers qw(:std);

my $line_count = 0;
my $verse_count = 0;
my $form = '';

require 'lib/Compose_Verse.pm';
require 'lib/Villanelle.pm';
require 'lib/Single_Verse_Forms.pm';
require 'lib/Forbidden_Words.pm';

# Pantoum
# From Wikipedia, the free encyclopedia
# The pantoum is a form of poetry similar to a villanelle. It is composed of a series of quatrains; 
# the second and fourth lines of each stanza are repeated as the first and third lines of the next...
# except for the final stanza [in which t]he first and third lines... are the second and fourth of the penultimate;
# also, the first line of the poem is the last line of the final stanza,
# and the third line of the first stanza is the second of the final.

# from http://www.baymoon.com/~ariadne/form/pantoum.htm

#       1  2  3  4          - Lines in first quatrain.
#       2  5  4  6          - Lines in second quatrain.
#       5  7  6  8          - Lines in third quatrain.
#       7  9  8 10          - Lines in fourth quatrain.
#       9  3 10  1          - Lines in fifth and final quatrain.

# TODO notification is not fully enabled for the pantoum, because it
# is not currently possible to count its verses.

my $pantoum_verse_count = 0;

sub pantoum{

    my $overall_verse_count = 0;

    while ($pantoum_verse_count < 2)
    {
        $overall_verse_count = &ask_for_int("To be interesting, a pantoum must have at least 5 verses.\nHow many verses would you like to write?");
        $pantoum_verse_count = $overall_verse_count - 3;
        # TODO a blank entry should default to 5
    }

    my $humanized_verse_count = to_string($overall_verse_count);

    my %make_title = (
                      lines => 0, # will result in just the time stamp being printed
                      # TODO capitalize the titles of pantoums
                      form => "$humanized_verse_count stanzas (pantoum)"
                     );



    # print the time stamp and initialize the verse counter

    compose_verse(\%make_title);

    my $first_line = &ask_for_line(++$line_count);
    my $second_line = &ask_for_line(++$line_count);
    my $third_line = &ask_for_line(++$line_count);
    my $fourth_line = &ask_for_line(++$line_count);

    my @first_verse = (
                      $first_line,
                      $second_line,
                      $third_line,
                      $fourth_line
                      );

    my @rest_of_verses;

    my @last_generated_verse = @first_verse;

    while ($pantoum_verse_count > 0){

      my @verse = verse_for_pantoum(@last_generated_verse);

      push @rest_of_verses, \@verse;

      @last_generated_verse = @verse;

      $pantoum_verse_count--;

    }

    my @penultimate_verse =  verse_for_pantoum(@last_generated_verse);

    my @last_verse = (
                      $penultimate_verse[1],
                      $first_verse[2],
                      $penultimate_verse[3],
                      $first_verse[0]
                     );


    &printer_for_verse(@first_verse);


    foreach my $stanza (@rest_of_verses)
    {
        &printer_for_verse( @{ $stanza } );
    }


    &printer_for_verse(@penultimate_verse);

    &printer_for_verse(@last_verse);


}

sub verse_for_pantoum{

    my @previous_verse = @_;
    my @new_verse = (
                     $previous_verse[1],
                     &ask_for_line($line_count += 2),
                     $previous_verse[3],
                     &ask_for_line($line_count += 2)
                    );

    return @new_verse;
}

1;
