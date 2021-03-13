class Association < ApplicationRecord
    has_many :agents

    validates :name, presence: true, uniqueness: true
    validates :description, presence: true
end
