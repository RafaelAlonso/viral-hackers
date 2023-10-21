class ScriptOutputJob < ApplicationJob
  queue_as :default

  def perform(script_id)
    script = Script.find_by(id: script_id)
    return unless script.present?

    output = Chains::MainChain.call(script)
    script.update(output: output, status: :complete)
  rescue StandardError => e
    script.update(status: :failed)
  end
end
