class ApiController < ApplicationController

  skip_before_action :verify_authenticity_token
  
  private
    def authenticated?
      authenticate_or_request_with_http_basic do |username, password|
        puts username, password
        user = User.find_by(name: username)
        if user.present?
          user.valid_password?(password)
        else
          false
        end
      end
    end

end
