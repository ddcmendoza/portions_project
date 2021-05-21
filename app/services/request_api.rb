class RequestApi
    def initialize(resource)
        @email = resource[:email]
    end
    
    def request
        require 'rest-client'
        res = RestClient.post("http://#{Rails.application.credentials[Rails.env.to_sym][:url]}/api/v1/users",{email: @email})
        res_json = JSON.parse(res)
        return {uuid: res_json["uuid"], api_key: res_json["api_token"]}
    end
end