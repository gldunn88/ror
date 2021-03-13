class Agent < ApplicationRecord
    has_many :agent_skills
    has_many :skills, through: :agent_skills
    has_many :agent_stats
    has_many :stats, through: :agent_stats
    has_many :associations
end
