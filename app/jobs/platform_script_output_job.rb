class PlatformScriptOutputJob < ApplicationJob
  queue_as :default

  def perform(platform_script_id)
    platform_script = PlatformScript.find_by(id: platform_script_id)
    return unless platform_script.present? && platform_script.pending?

    output = Chains::LongVideoChain.call(platform_script)
    platform_script.update(output: output, status: :complete)
  rescue StandardError => e
    platform_script.update(status: :failed)
  end
end
