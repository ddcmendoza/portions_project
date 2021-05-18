class IngredientsController < ApplicationController
  def index; end

  def show; end

  def edit; end

  def update; end

  def new; end

  def create; end

  def destroy
    Ingredient.destroy(params[:id])
  end
end
