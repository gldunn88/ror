class AgentStat < ApplicationRecord
    belongs_to :agent
    belongs_to :stat

    validates :stat_value, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
    validates :stat, uniqueness: {scope: :agent, message: "agent already has stat" }
end
