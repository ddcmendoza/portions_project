class Ingredient < ApplicationRecord
  has_and_belongs_to_many :recipes, join_table: 'ingredients_recipes'

  validates :name, presence: true
  validates :measurement, presence: true
  before_save :build_specification
  validates :specification, uniqueness: true

  def self.specification_valid?(spec)
    where(specification: spec).length.zero?
  end

  private

  def build_specification
    self.specification = "#{name.downcase}-#{brand == '' ? '0' : brand.downcase}-#{measurement.downcase}-#{measurement_value}"
    throw :abort unless Ingredient.specification_valid?(specification)
  end
end
