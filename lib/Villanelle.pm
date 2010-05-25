# Here is wikipedia on the form of the villanelle

# A villanelle is a poetic form which entered English-language poetry
# in the 1800s from the imitation of French models. The word
# derives from the Italian villanella from Latin villanus
# (rustic).  A villanelle has only two rhyme sounds. The first and
# third lines of the first stanza are rhyming refrains that alternate
# as the third line in each successive stanza and form a couplet at
# the close. A villanelle is nineteen lines long, consisting of five
# tercets and one concluding quatrain.  In music, it is a dance
# form, accompanied by sung lyrics or an instrumental piece based on
# this dance form.

# The villanelle has no established meter, although most
# nineteenth-century villanelles have used trimeter or tetrameter and
# most twentieth-century villanelles have used pentameter. The essence
# of the fixed modern form is its distinctive pattern of rhyme and
# repetition. The rhyme-and-refrain pattern of the villanelle can be
# schematized as A1bA2 abA1 abA2 abA1 abA2 abA1A2 where letters ("a"
# and "b") indicate the two rhyme sounds, upper case indicates a
# refrain ("A"), and superscript numerals (1 and 2) indicate Refrain 1
# and Refrain 2.

# Refrain 1 (A1)
# Line 2 (b)
# Refrain 2 (A2)
#
# Line 4 (a)
# Line 5 (b)
# Refrain 1 (A1)
#
# Line 7 (a)
# Line 8 (b)
# Refrain 2 (A2)
#
# Line 10 (a)
# Line 11 (b)
# Refrain 1 (A1)
#
# Line 13 (a)
# Line 14 (b)
# Refrain 2 (A2)
#
# Line 16 (a)
# Line 17 (b)
# Refrain 1 (A1)
# Refrain 2 (A2)
#
# Dylan Thomas' "Do Not Go Gentle into That Good Night" is an exemplar:
#
# 1. A1: Do not go gentle into that good night,
# 2. b:  Old age should burn and rave at close of day;
# 3. A2: Rage, rage against the dying of the light.
#
# 4. a:  Though wise men at their end know dark is right,
# 5. b:  Because their words had forked no lightning they
# 6. A1: Do not go gentle into that good night.
#
# 7. a:  Good men, the last wave by, crying how bright
# 8. b:  Their frail deeds might have danced in a green bay,
# 9. A2: Rage, rage against the dying of the light.
#
# 10. a:  Wild men who caught and sang the sun in flight,
# 11. b:  And learn, too late, they grieved it on its way,
# 12. A1: Do not go gentle into that good night.
#
# 13. a:  Grave men, near death, who see with blinding sight
# 14. b:  Blind eyes could blaze like meteors and be gay,
# 15. A2: Rage, rage against the dying of the light.
#
# 16. a:  And you, my father, there on the sad height,
# 17. b:  Curse, bless, me now with your fierce tears, I pray.
# 18. A1: Do not go gentle into that good night.
# 19. A2: Rage, rage against the dying of the light.

# Since it is of a fixed length, the Villanelle can be treated as a
# single verse with some blank lines.

sub villanelle{

    my %first_line = (
                      lines => 0, # will result in just the time stamp being printed
                      form => "Villanelle"
                     );

    # print the time stamp and initialize the verse counter
    compose_verse(\%first_line);

    my $refrain_1 = &ask_for_line(1);
    my $second_line  = &ask_for_line(2);
    my $refrain_2 = &ask_for_line(3);

    ++$verse_count;

    my $fourth_line = &ask_for_line(1);
    my $fifth_line = &ask_for_line(2);

    ++$verse_count;

    my $seventh_line = &ask_for_line(1);
    my $eighth_line = &ask_for_line(2);

    ++$verse_count;

    my $tenth_line = &ask_for_line(1);
    my $eleventh_line = &ask_for_line(2);

    ++$verse_count;

    my $thirteenth_line = &ask_for_line(1);
    my $fourtheenth_line = &ask_for_line(2);

    ++$verse_count;

    my $sixteenth_line = &ask_for_line(1);
    my $seventeenth_line = &ask_for_line(2);

    my @poem = (

                $refrain_1,
                $second_line,
                $refrain_2,
                '',
                $fourth_line,
                $fifth_line,
                $refrain_1,
                '',
                $seventh_line,
                $eighth_line,
                $refrain_2,
                '',
                $tenth_line,
                $eleventh_line,
                $refrain_1,
                '',
                $thirteenth_line,
                $fourtheenth_line,
                $refrain_2,
                '',
                $sixteenth_line,
                $seventeenth_line,
                $refrain_1,
                $refrain_2
               );



    &printer_for_verse( @poem );

}

1;
