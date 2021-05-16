class Recipe < ApplicationRecord
  belongs_to :recipe_category
  belongs_to :parent, class_name: 'Recipe', optional: true, inverse_of: :children
  has_many :children, class_name: 'Recipe', foreign_key: 'parent_id', inverse_of: :parent, dependent: :nullify
  has_and_belongs_to_many :ingredients, join_table: 'ingredients_recipes'

  validates :name, presence: true

  accepts_nested_attributes_for :ingredients, reject_if: ->(attributes) { attributes['name'].blank? }, allow_destroy: true
end
