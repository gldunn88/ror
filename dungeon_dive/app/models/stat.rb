class Stat < ApplicationRecord
    has_many :skills
    has_many :agent_stats
    has_many :agents, through: :agent_stats

    validates :name, presence: true, uniqueness: true, inclusion: { in: %w(Strength Agility Toughness Cleverness Awareness),
        message: "%{value} is not a valid stat name" }
    validates :description, presence: true
    
    def display_name
        "#{name}"
    end
end
