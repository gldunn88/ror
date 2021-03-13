class AgentSkill < ApplicationRecord
    belongs_to :agent
    belongs_to :skill

    validates :modifier, presence: true, numericality: { only_integer: true}
    validates :skill, uniqueness: {scope: :agent, message: "agent already has skill"}
end
