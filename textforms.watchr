# Run me with:
#   watchr -d textforms.watchr
#
# Also requires Watchr and following other ruby gems:
#     sudo gem install watchr ruby-growl rev
#
# To use fsevent on MacOS, you currently have to patch the Watchr gem as described here:
# https://github.com/mynyml/watchr/issues/36#issuecomment-7794856

@growl_clients = %w{
    127.0.0.1
}

def check action, title, message
  guid = %x{echo '#{title}' | sha1sum - | cut -d' ' -f1}.chomp
  if system %{set -x; #{action} > /tmp/#{guid}_output}
    if system %{test -e /tmp/#{guid}}
      puts "\033[32;1m" + title + " RECOVERY\n\t" + message + "\033[0m"
      system %{rm /tmp/#{guid}}
      @growl_clients.each do | host  |
        system %{growl -H #{host} -t 'RECOVERED OK: #{title}' -m '#{message}'}
      end
    end
  else
    puts "\033[31;1m" + title + " FAILURE\n\t" + message + "\033[0m"
    system %{touch /tmp/#{guid}}
    @growl_clients.each do | host  |
      system %{growl -H #{host} -t 'FAIL: #{title}' -m '#{message}'}
    end
  end
  puts %x{cat /tmp/#{guid}_output}
end

# Rules
#
# Less specific rules should be listed first.

watch( '(.*/(.*(:?pl|pm))$)' )  { |m|
  check(%{prove t},
        "Tests for #{m[2]}",
        m[1])
}

# Press Ctl-C to quit.

Signal.trap('INT' ) { abort("\n") } # Ctrl-C
