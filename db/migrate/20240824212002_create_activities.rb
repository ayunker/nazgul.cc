class CreateActivities < ActiveRecord::Migration[7.2]
  def change
    create_table :activities do |t|
      t.bigint :strava_id, null: false
      t.string :external_id
      t.string :name
      t.decimal :distance, precision: 10, scale: 2
      t.decimal :moving_time, precision: 10, scale: 2
      t.decimal :elapsed_time, precision: 10, scale: 2
      t.date :activity_date
      t.string :bike
      t.decimal :average_speed, precision: 10, scale: 2
      t.decimal :max_speed, precision: 10, scale: 2
      t.decimal :average_watts, precision: 10, scale: 2
      t.boolean :with_kat, null: false, default: false

      t.timestamps
    end
  end
end
