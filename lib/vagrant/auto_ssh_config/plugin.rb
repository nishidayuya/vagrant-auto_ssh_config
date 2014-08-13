module Vagrant
  module AutoSshConfig
    class Plugin < Vagrant.plugin("2")
      name "vagrant-auto_ssh_config"

      action_hook("vagrant-auto_ssh_config: update") do |hook|
        require_relative "action/create_or_update"
        hook.before(Vagrant::Action::Builtin::WaitForCommunicator,
                    Action::CreateOrUpdate)
      end

      action_hook("vagrant-auto_ssh_config: delete") do |hook|
        require_relative "action/delete"
        hook.before(Vagrant::Action::Builtin::GracefulHalt, Action::Delete)
      end
    end
  end
end
