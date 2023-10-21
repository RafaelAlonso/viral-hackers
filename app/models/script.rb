class Script < ApplicationRecord
  belongs_to :user

  enum category: {
    health: 0,
    personal_development: 1,
    marketing: 2,
    traveling: 3,
    technology: 4
  }

  enum mood: {
    informative: 0,
    inspirational: 1,
    conversational: 2,
    formal: 3,
    informal: 4,
    authoritative: 5,
    friendly: 6,
    humorous: 7,
    enthusiastic: 8,
    educational: 9,
    empathetic: 10,
    motivational: 11,
    salesperson: 12,
    concise: 13,
    personal: 14,
    sarcastic: 15,
    optimistic: 16,
    pessimistic: 17,
    skeptical: 18,
    romantic: 19,
    appreciative: 20,
    sensitive: 21,
    energetic: 22,
    calm: 23,
    challenging: 24,
    professional: 25,
    casual: 26,
    encouraging: 27,
    narrative: 28,
    relaxed: 29,
  }

  enum status: {
    pending: 0,
    complete: 1,
    failed: 2,
    canceled: 3
  }

  validates :category, :context, :duration, :mood, :status, presence: true
  validates :duration, inclusion: { in: [30, 60, 120] }
  validates :description, length: { minimum: 5, maximum: 250 }, allow_blank: true

  def self.humanized_categories
    {
      'Saúde': 'health',
      'Desenvolvimento Pessoal': 'personal_development',
      'Marketing': 'marketing',
      'Viagens': 'traveling',
      'Tecnologia': 'technology',
    }
  end
end
