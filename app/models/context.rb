class Context < ApplicationRecord
  belongs_to :category
  has_many :scripts, through: :category
end
