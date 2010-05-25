# Pantoum

A natural language (poetry) template engine that will someday grow
powerful enough to help you produce a pantoum (see Wikipedia if you
aren't familiar with that poetic form).

## How to use

Just invoke the script and it will launch an interactive shell.  Poems
you create will be saved under your DROPBOX_PATH as described below
under Dependencies.

## Dependencies

This path must exist on your system:

    $DROPBOX_PATH/journal/textforms.txt

That is, you *must* have an environment variable called `DROPBOX_PATH`
and it must point to a directory containing a folder called journal
which in turn contains a text file called textforms.txt

You could even set up a Dropbox account and set your DROPBOX_PATH to
point there.  Or not.

### Perl Modules

In order to run Textforms, you need the Lingua Any Numbers module from
CPAN.  Use the following command (you may need to `sudo`)

      cpan Lingua::Any::Numbers

If you're on Windows and that fails, try installing 
[Strawberry Perl,](http://strawberryperl.com/ "Larry Wall recommends Strawberry Perl for Windows")
then rerunning the command.

