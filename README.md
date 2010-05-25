# Textforms

## Synopsis

   perl script/shell.pl

A natural language (poetry) template engine that will someday grow
powerful enough to help you produce a pantoum (see Wikipedia if you
aren't familiar with that poetic form). Just invoke the script and it
will launch an interactive shell.

## How do I stop it?

The shell runs until you force it to quit by pressing
Control C.

## Where are my poems saved?

Poems you create will be saved in `poetry/textforms.txt`.

If you want to save poems somewhere else, the path is set at the top
of `lib/Compose_Verse.pm`

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
