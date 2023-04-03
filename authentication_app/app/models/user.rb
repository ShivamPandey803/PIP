class User < ApplicationRecord
has_secure_password
  
def self.from_token_payload(payload)
    find(payload['sub'])
end
  
def self.from_credentials(email, password)
    user = find_by(email: email)
    return unless user
    return user if user.authenticate(password)
end
  
def to_token_payload
    { sub: id }
end
  
def jwt(exp = 24.hours.from_now)
    payload = to_token_payload
    payload[:exp] = exp.to_i
    JWT.encode(payload, Rails.application.secret_key_base)
end
end
  