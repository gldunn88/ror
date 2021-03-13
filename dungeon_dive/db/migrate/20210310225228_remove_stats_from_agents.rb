class RemoveStatsFromAgents < ActiveRecord::Migration[6.1]
  def change
    remove_column :agents, :strength, :integer
    remove_column :agents, :agility, :integer
    remove_column :agents, :constitution, :integer
    remove_column :agents, :awareness, :integer
  end
end
