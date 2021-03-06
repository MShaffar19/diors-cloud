module Cloud

  module Command

    class Suspend < Base

      def execute
        require_args(:project, :user)
        with_vm(:running, :saved) { |vm| vm.action(:suspend) and true }
      end

      register(:execute, skip_hook_when: false) { machine.to_suspend }
      register(:execute) do
        Cloud::Notify::Hubot.send(user.email, errors | "Machine of `#{project.name}` has been suspended.")
      end
    end
  end
end
