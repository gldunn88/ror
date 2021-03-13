class AddAgentToAgentSkill < ActiveRecord::Migration[6.1]
  def change
    add_reference :agent_skills, :agent, null: false, foreign_key: true
  end
end
