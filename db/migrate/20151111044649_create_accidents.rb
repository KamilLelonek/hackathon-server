class CreateAccidents < ActiveRecord::Migration
  def change
    create_table :accidents, id: :uuid do |column|
      column.string :drone_id, null: true

      column.string :station_id, null: false
      column.string :user_id,    null: false

      column.integer :kind,   null: false, default: 0
      column.integer :status, null: false, default: 0

      column.float :lat, null: false
      column.float :lng, null: false

      column.timestamps null: false
    end
  end
end
