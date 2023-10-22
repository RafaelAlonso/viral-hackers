class PlatformScript < ApplicationRecord
  belongs_to :script

  validates :platform, presence: true

  after_save :broadcast_update

  enum status: {
    pending: 0,
    complete: 1,
    failed: 2,
    canceled: 3
  }

  STATUS_PT_BR = {
    'pending' => 'processando',
    'complete' => 'completo',
    'failed' => 'erro',
    'canceled' => 'cancelado'
  }.freeze

  def status_to_pt_br
    STATUS_PT_BR[status]
  end

  private

  def broadcast_update
    script.broadcast_replace_later_to(script, target: "script_#{script.id}", partial: 'scripts/script', script: script)
  end
end
