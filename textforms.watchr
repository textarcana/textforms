# Run me with:
#   watchr -d textforms.watchr
#
# Also requires Watchr and following other ruby gems:
#     sudo gem install watchr ruby-growl rev
#
# To use fsevent on MacOS, you currently have to patch the Watchr gem as described here:
# https://github.com/mynyml/watchr/issues/36#issuecomment-7794856
#
# The Devel::Cover cli was installed (by Macports) )in a directory
#   which wasn't in my PATH.  I used "locate bin/cover" to find it.


@growl_clients = %w{
    127.0.0.1
}

def check action, title, message
  guid = %x{echo '#{title}' | sha1sum - | cut -d' ' -f1}.chomp
  if system %{set -x; #{action}}
    if system %{test -e /tmp/#{guid}}
      puts "\033[32;1m" + title + " RECOVERY\n\t" + message + "\033[0m"
      system %{rm /tmp/#{guid}}
      @growl_clients.each do | host  |
        system %{growl -H #{host} -t 'RECOVERED OK: #{title}' -m '#{message}'}
      end
    end
    return true
  else
    puts "\033[31;1m" + title + " FAILURE\n\t" + message + "\033[0m"
    system %{touch /tmp/#{guid}}
    @growl_clients.each do | host  |
      system %{growl -H #{host} -t 'FAIL: #{title}' -m '#{message}'}
    end
    return false
  end
end

`which cover` or raise "Please install Devel::Cover via CPAN"
`which prove` or raise "Please install Test::More via CPAN"

@unit_tests = %{prove --jobs 10}

@code_coverage = %{
time (PERL5OPT=-MDevel::Cover prove 2>&1> /dev/null && \
      cover -silent -select=lib/*)
}

# Rules
#
# Less specific rules should be listed first.

watch( '(.*/(.*\.(:?pl|pm|t))$)' )  { |m|
  check(%{perl -c m[1]},
        "Syntax check for #{m[2]}",
        m[1])
}

watch( '(.*/(.*\.(:?pl|pm|t))$)' )  { |m|
  status_ok = check(@unit_tests,
                    "Tests for #{m[2]}",
                    m[1])

  if status_ok
    puts "\n\033[32;1m" + "Code Coverage" + "\033[0m"
    system @code_coverage
  end
}

# Press Ctl-C to quit.

Signal.trap('INT' ) { abort("\n") } # Ctrl-C
