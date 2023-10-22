class Script < ApplicationRecord
  # associations
  belongs_to :user
  belongs_to :category
  has_many :contexts, through: :category

  # validations
  validates :duration, :mood, :status, presence: true
  validates :duration, inclusion: { in: [30, 60, 120] }
  validates :description, length: { minimum: 5, maximum: 250 }, allow_blank: true

  # callbacks
  after_update :broadcast_update

  # enums
  enum mood: {
    informativo: 0,
    inspiracional: 1,
    conversacional: 2,
    formal: 3,
    informal: 4,
    autoritário: 5,
    amigável: 6,
    humorístico: 7,
    entusiasmado: 8,
    educacional: 9,
    empático: 10,
    motivacional: 11,
    vendedor: 12,
    conciso: 13,
    pessoal: 14,
    sarcástico: 15,
    otimista: 16,
    pessimista: 17,
    cético: 18,
    romântico: 19,
    apreciativo: 20,
    sensível: 21,
    energético: 22,
    tranquilo: 23,
    desafiador: 24,
    profissional: 25,
    casual: 26,
    encorajador: 27,
    narrativo: 28,
    descontraído: 29,
  }
  enum status: {
    pending: 0,
    complete: 1,
    failed: 2,
    canceled: 3
  }

  private

  def broadcast_update
    broadcast_replace_later_to(self)
  end
end
