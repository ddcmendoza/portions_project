class RecipeCategory < ApplicationRecord
  has_many :recipes, dependent: :nullify
  belongs_to :user

  validates :name, presence: true
end
