class FetchPrice < ApplicationService
  def initialize(params)
    @name = params[:name]
    @brand = params[:brand]
    @measurement = params[:measurement]
    @measurement_value = params[:measurement_value]
  end

  def call
    require 'rest-client'
    JSON.parse(RestClient.get("https://#{Rails.application.credentials[:production][:url]}/api/v1/ingredients/price?name=#{@name}&brand=#{@brand}&measurement=#{@measurement}&measurement_value=#{@measurement_value}"))
  end
end
