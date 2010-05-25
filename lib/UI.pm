#! /opt/local/bin/perl -w
use strict;
use Lingua::Any::Numbers qw(:std);

#Let the user choose what type of poetic form to generate
sub start_command_shell{
    my $option_id = 0;
    my $selection;
    my @form_titles = (
                            'Couplet',
                            'Haiku',
                            'Quatrain',
                            'Sonnet',
			    'English Sonnet',
			    'Italian Sonnet',
                            'Concrete Poem',
                            'Linked Haiku',
                            'Linked Couplets',
                            'Villanelle',
                            'Pantoum',
                       );

    my @forms = (
                 \&compose_couplet,
                 \&compose_haiku,
                 \&compose_quatrain,
                 \&compose_sonnet,
		 \&compose_english_sonnet,
		 \&compose_italian_sonnet,
                 \&compose_concrete,
                 \&five_haiku,
                 \&eight_couplets,
                 \&villanelle,
                 \&pantoum
                );

    &clear_screen;

    foreach my $choice (@form_titles)
    {

        print "$option_id $choice\n";
        $option_id++;

    }

    print "\nWhat type of poetic form would you like to generate?\n";
    chomp($selection = <STDIN>);
    die "FAIL: You must enter a number corresponding to an option." unless ($form_titles[$selection] ne "");

    $forms[$selection]->();

    # in production mode, run forever, C-c to quit
    &start_command_shell unless $ARGV[0];

}


sub printer_for_verse{

    my @verse = @_;

    &printer_for_poetry(@verse);

    &printer_for_poetry((""));

}

1;
