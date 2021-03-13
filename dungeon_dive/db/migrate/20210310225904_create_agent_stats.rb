class CreateAgentStats < ActiveRecord::Migration[6.1]
  def change
    create_table :agent_stats do |t|
      t.integer :stat_value

      t.timestamps
    end
  end
end
