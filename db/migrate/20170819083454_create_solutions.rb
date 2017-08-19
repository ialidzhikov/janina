class CreateSolutions < ActiveRecord::Migration[5.1]
  def change
    create_table :solutions do |t|
      t.references :user, null: false
      t.references :task, null: false
      t.integer    :points, null: false, default: 0

      t.timestamps
    end

    add_foreign_key :solutions, :users
    add_foreign_key :solutions, :tasks

    add_index :solutions, [:task_id, :user_id], unique: true
  end
end
