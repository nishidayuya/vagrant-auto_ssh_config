require "open3"

module Vagrant
  module AutoSshConfig
    module Action
      class Base
        def initialize(app, env, options = {})
          @app = app
          @options = options
        end

        def call(env)
          @app.call(env)
          run(env)
        end

        def run(env)
          env[:ui].info("#{doing_prefix} ssh_config for current box...")

          SSH_CONFIG_PATH.open(File::RDWR | File::CREAT) do |f|
            f.flock(File::LOCK_EX)
            old_ssh_config = f.read
            ssh_config_without_myself =
              old_ssh_config.gsub(TEMPLATE_REGEXP, "").
              sub(/\n?\n?\z/, "")
            new_ssh_config = create_new_ssh_config(ssh_config_without_myself)
            if old_ssh_config == new_ssh_config
              env[:ui].info("not changed.")
              return
            end
            begin
              f.rewind
              f.puts(new_ssh_config)
            rescue
              f.rewind
              f.write(old_ssh_config)
              raise
            ensure
              f.flush
              f.truncate(f.pos)
            end
          end
          env[:ui].detail("#{done_prefix} ssh_config for current box.")
        end

        private

        SSH_CONFIG_PATH = Pathname("~/.ssh/config").expand_path
        SSH_CONFIG_TEMPLATE = <<EOS.chomp.freeze
# BEGIN vagrant-auto_ssh_config
# These are automatically generated configurations by vagrant-auto_ssh_config.

%{configurations}

# END vagrant-auto_ssh_config
EOS
        ary = SSH_CONFIG_TEMPLATE.split("\n")
        begin_mark = ary.first
        end_mark = ary.last
        TEMPLATE_REGEXP = /#{begin_mark}.*?#{end_mark}\n/m

        def doing_prefix
          raise NotImplementedError, "Subclass must implement."
        end

        def done_prefix
          raise NotImplementedError, "Subclass must implement."
        end

        def create_new_ssh_config(ssh_config_without_myself)
          raise NotImplementedError, "Subclass must implement."
        end
      end
    end
  end
end
