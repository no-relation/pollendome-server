class User < ApplicationRecord
    has_many :feelings
    has_many :days, through: :feelings
    has_secure_password

    def token
        JWT.encode({ user_id: self.id }, ENV['JWT_secret']) 
    end
end
