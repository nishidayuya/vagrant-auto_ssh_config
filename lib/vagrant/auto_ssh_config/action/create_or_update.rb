require_relative "base"

module Vagrant
  module AutoSshConfig
    module Action
      class CreateOrUpdate < Base
        private

        def doing_prefix
          return "Creating/Updating"
        end

        def done_prefix
          return "Created/Updated"
        end

        def create_new_ssh_config(ssh_config_without_myself)
          # dirty hack
          config = `vagrant ssh-config --host vagrant-latest`
          config = config[/^Host .*LogLevel FATAL\n/m].strip
          additionals = SSH_CONFIG_TEMPLATE % {configurations: config}
          return <<EOS
#{ssh_config_without_myself}

#{additionals}
EOS
        end
      end
    end
  end
end
