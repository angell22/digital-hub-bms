class CreateRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :rooms do |t|
      t.string :room_name
      t.decimal :rate
      t.string :capacity
      t.timestamps 
    end
  end
end
