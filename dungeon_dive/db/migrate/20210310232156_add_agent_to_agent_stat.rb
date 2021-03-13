class AddAgentToAgentStat < ActiveRecord::Migration[6.1]
  def change
    add_reference :agent_stats, :agent, null: false, foreign_key: true
  end
end
