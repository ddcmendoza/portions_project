class FetchPrice < ApplicationService
    def initialize(params)
        @name = params[:name]
        @brand = params[:brand]
        @measurement = params[:measurement]
        @measurement_value = params[:mvalue]
    end
    
    def call
        require 'rest-client'
        return JSON.parse(RestClient.post("http://#{Rails.application.credentials[Rails.env.to_sym][:url]}/api/v1/ingredients/price",  {
            name: @name,
            brand: @brand,
            measurement: @measurement,
            measurement_value: @measurement_value
        }))
    end

end