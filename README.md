# Textforms

## Synopsis

       perl script/shell.pl

Textforms is an interactive poetry template engine.

If you seed a random number generator with numbers, then it stands to
reason that you should seed a poetry generator with poetry.

Poems you create will be saved in `poetry/textforms.txt`.  If you want
to save poems somewhere else, the path is set at the top of
`lib/Compose_Verse.pm`

## How do I stop it?

The shell runs until you force it to quit by pressing
Control C.

## Forbidden Words

Textforms allows you to define a dictionary of words you don't want to
be allowed in your poems.  

Only a couple of example words are forbidden by default.  You can
forbid more words by editing `lib/dictionary_of_forbidden_words`

## Dependencies

In order to run Textforms, you need the Lingua module from CPAN.
Lingua is used to display the line numbers while you are composing.
Use the following command (you may need to `sudo`)

      cpan Lingua::Any::Numbers

If you're on Windows and that fails, try installing 
[Strawberry Perl,](http://strawberryperl.com/ "Larry Wall recommends Strawberry Perl for Windows")
then rerunning the command.

## Known Issues

Don't trust the line numbers when you are composing Pantoums.  Line
numbers should be correct for other poetic forms, however.
