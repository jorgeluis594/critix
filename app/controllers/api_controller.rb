class ApiController < ActionController::API
    acts_as_token_authentication_handler_for User, fallback_to_devise: false
end