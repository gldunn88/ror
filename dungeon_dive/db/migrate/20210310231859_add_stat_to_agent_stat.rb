class AddStatToAgentStat < ActiveRecord::Migration[6.1]
  def change
    add_reference :agent_stats, :stat, null: false, foreign_key: true
  end
end
