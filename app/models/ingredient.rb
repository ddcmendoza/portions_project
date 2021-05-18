class Ingredient < ApplicationRecord
  has_and_belongs_to_many :recipes, join_table: 'ingredients_recipes'
  has_many :ingredients_recipe, dependent: :destroy
  validates :name, presence: true
  validates :name, uniqueness: { scope: :brand }

  # accepts_nested_attributes_for :ingredients_recipes, reject_if: ->(attributes) { attributes['measurement'].blank? }, allow_destroy: true
  # validates :measurement, presence: true
  # before_save :build_specification
  # validates :specification, uniqueness: true replaced with build_specification

  # def self.specification_valid?(spec)
  #   where(specification: spec).length.zero?
  # end

  # def build_specification
  #   logger.info "Building Specification for Ingredient #{name}"
  #   self.specification = "#{name.downcase}-#{brand == '' ? '0' : brand.downcase}-#{measurement.downcase}-#{measurement_value}"
  #   throw :abort unless Ingredient.specification_valid?(specification)
  # end
end
