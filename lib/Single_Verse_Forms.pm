# Single-verse poetic forms

my %untitled_couplet = (
    no_stamp => 1,
    lines => 2
    );

my %untitled_quatrain = (
    no_stamp => 1,
    lines => 4
    );

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

# TODO Sonnets are not strictly supposed to contain blank lines between stanzas
# According to wikipedia, the english sonnet is 3 quatrains and a couplet

sub compose_english_sonnet{
    my %first_quatrain = (
	lines => 4,
	form => 'English Sonnet'
	);

    compose_verse(\%first_quatrain);
    compose_verse(\%untitled_quatrain);
    compose_verse(\%untitled_quatrain);
    compose_verse(\%untitled_couplet);
}

# according to wikipedia, the first 2 quatrains (the octave) should
# describe a problem and the last 2 tercets (the sestet) should
# describe its solution.

sub compose_italian_sonnet{
    my %first_quatrain = (
	lines => 4,
	form => 'Italian Sonnet'
	);

    my %untitled_tercet = (
			   lines => 3,
			   no_stamp => 1
			  );

    compose_verse(\%first_quatrain);
    compose_verse(\%untitled_quatrain);
    compose_verse(\%untitled_tercet);
    compose_verse(\%untitled_tercet);
}

# Concrete poem is a contrived (one-verse) form where no line can be longer than the first
sub compose_concrete{
    my %concrete = (
                    form => 'Concrete Poem',
                    longest_line => 1,
                    arbitrary_length => 'true'
                   );

    compose_verse(\%concrete);
}
;

sub eight_couplets{

    my %first_couplet = (
                         lines => 2,
                         form => 'Eight Couplets'
                        );



    compose_verse(\%first_couplet);

    compose_verse(\%untitled_couplet);
    compose_verse(\%untitled_couplet);
    compose_verse(\%untitled_couplet);
    compose_verse(\%untitled_couplet);
    compose_verse(\%untitled_couplet);
    compose_verse(\%untitled_couplet);
    compose_verse(\%untitled_couplet);


}

sub five_haiku{

    my %first_haiku = (
                       longest_line => 2,
                       lines => 3,
                       form => 'Five Haiku'
                      );

    my %untitled_haiku = (
                          no_stamp => 1,
                          longest_line => 2,
                          lines => 3
                         );

    compose_verse(\%first_haiku);
    compose_verse(\%untitled_haiku);
    compose_verse(\%untitled_haiku);
    compose_verse(\%untitled_haiku);
    compose_verse(\%untitled_haiku);


}

1;
