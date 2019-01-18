class Day < ApplicationRecord
    has_many :feelings
    has_many :users, through: :feelings
end
