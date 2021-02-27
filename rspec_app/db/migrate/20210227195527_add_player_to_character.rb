class AddPlayerToCharacter < ActiveRecord::Migration[6.1]
  def change
    add_reference :characters, :player, null: false, foreign_key: true
  end
end
