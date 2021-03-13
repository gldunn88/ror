class CreateAgentSkills < ActiveRecord::Migration[6.1]
  def change
    create_table :agent_skills do |t|
      t.integer :modifier

      t.timestamps
    end
  end
end
