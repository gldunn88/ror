class AddStatToSkills < ActiveRecord::Migration[6.1]
  def change
    add_reference :skills, :stat, null: false, foreign_key: true
  end
end
