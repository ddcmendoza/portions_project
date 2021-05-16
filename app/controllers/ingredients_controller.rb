class IngredientsController < ApplicationController
  def index; end

  def show; end

  def edit; end

  def update; end

  def new; end

  def create; end

  def ingredient_form
    @ingredient =  Ingredient.new
    render layout: false
  end
end
