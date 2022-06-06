require "jwt"

# For creating Json Web Tokens using the rails' secret key, user id and token expiration time as the payload data.
module JsonWebToken
    extend ActiveSupport::Concern
    SECRET_KEY = Rails.application.secret_key_base

    # Method for encoding aor creating a token using the JWT gem class's encode method.
    # Payload consists of user id and token expiration is set as 1 minute.
    def jwt_encode(payload, exp = 1.minutes.from_now)
        payload[:exp] = exp.to_i
        JWT.encode(payload, SECRET_KEY)
    end

    # Method for decoding a web token incoming from an api call, that needs to be decoded using rails app's secret key.
    def jwt_decode(token)
        decoded = JWT.decode(token, SECRET_KEY)[0]
        HashWithIndifferentAccess.new decoded
    end
end