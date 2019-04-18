class Day < ApplicationRecord
    has_many :feelings
    has_many :users, through: :feelings
    validates :fulldate, uniqueness: true
end
