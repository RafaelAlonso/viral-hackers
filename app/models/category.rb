class Category < ApplicationRecord
  has_many :contexts, dependent: :destroy
  has_many :scripts

  validates :name, uniqueness: true
end
