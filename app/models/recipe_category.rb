class RecipeCategory < ApplicationRecord
  has_many :recipes, dependent: :nullify
  belongs_to :user

  validates :name, presence: true
  validates :name, uniqueness: { scope: :user_id }
end
