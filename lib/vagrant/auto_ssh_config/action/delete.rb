require_relative "base"

module Vagrant
  module AutoSshConfig
    module Action
      class Delete < Base
        private

        def doing_prefix
          return "Deleting"
        end

        def done_prefix
          return "Deleted"
        end

        def create_new_ssh_config(ssh_config_without_myself)
          return ssh_config_without_myself
        end
      end
    end
  end
end
