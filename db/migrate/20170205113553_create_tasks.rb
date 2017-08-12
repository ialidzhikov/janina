class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.datetime :deadline, null: false
      t.integer :max_points, null: false
    end
  end
end
