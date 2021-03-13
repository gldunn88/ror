class RemoveStatFromSkills < ActiveRecord::Migration[6.1]
  def change
    remove_column :skills, :stat, :string
  end
end
