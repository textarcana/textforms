# Textforms

A natural language (poetry) template engine that will someday grow
powerful enough to help you produce a pantoum (see Wikipedia if you
aren't familiar with that poetic form).

## How to use

    perl script/shell.pl

Just invoke the script and it will launch an interactive shell.  Poems
you create will be saved in `poetry/textforms.txt`.  

If you want to save poems somewhere else, the path is set at the top
of `lib/ComposeVerse.pm`

## Dependencies

In order to run Textforms, you need the Lingua Any Numbers module from
CPAN.  Use the following command (you may need to `sudo`)

      cpan Lingua::Any::Numbers

If you're on Windows and that fails, try installing 
[Strawberry Perl,](http://strawberryperl.com/ "Larry Wall recommends Strawberry Perl for Windows")
then rerunning the command.

