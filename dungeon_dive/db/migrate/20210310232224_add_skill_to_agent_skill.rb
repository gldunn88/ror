class AddSkillToAgentSkill < ActiveRecord::Migration[6.1]
  def change
    add_reference :agent_skills, :skill, null: false, foreign_key: true
  end
end
