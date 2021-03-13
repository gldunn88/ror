class Skill < ApplicationRecord
    belongs_to :stat
    has_many :agent_skills
    has_many :agents, through: :agent_skills

    validates :name, presence: true, uniqueness: true
    validates :description, presence: true
    validates :stat, presence: true
end
