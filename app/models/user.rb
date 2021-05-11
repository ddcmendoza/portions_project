class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

    has_many :friends, :class_name => "User", :foreign_key => "friend_user_id"
    has_many :recipe_categories
    has_many :recipes, through: :recipe_categories

end
