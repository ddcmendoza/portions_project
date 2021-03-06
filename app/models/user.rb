class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # has_many :friends, class_name: 'User', foreign_key: 'friend_user_id', inverse_of: :friend #Implement https://hackernoon.com/how-to-create-a-friendship-relation-on-rails-c01d3u4v
  has_many :recipe_categories, dependent: :destroy
  has_many :recipes, through: :recipe_categories
  after_create :create_general_category

  validates :encrypted_password, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: 'Valid emails only!' }

  def number_forks
    count = 0
    recipes.each do |recipe|
      count += recipe.children.length
    end
    count
  end

  private

  def create_general_category
    recipe_categories << RecipeCategory.create(name: 'General', description: 'General recipe category', user_id: id)
  end
end
