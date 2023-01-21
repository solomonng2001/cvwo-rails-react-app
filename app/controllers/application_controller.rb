class ApplicationController < ActionController::API

    def jwt_key
        Rails.application.credentials.jwt_key
    end

    def encode(payload)
        JWT.encode(payload, jwt_key, 'HS256')
    end

    def decode(token)
        JWT.decode(token, jwt_key, true, { :algorithm => 'HS256' })
    end

    def auth_header
        request.headers['Authorization']
    end

    def decoded_token
        begin
            decode(auth_header)
        rescue
            [{error: "Invalid Token"}]
        end    
    end

    def current_user
        if !decoded_token.empty?
            user = User.find_by(id: decoded_token[0]["user_id"])
        else
            nil
        end
    end

    def logged_in
        !!current_user
    end

    def require_login
        render json: { error: ["Login required" ]}, status: :unauthorized unless logged_in
    end
end
