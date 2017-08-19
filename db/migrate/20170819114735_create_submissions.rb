class CreateSubmissions < ActiveRecord::Migration[5.1]
  def change
    create_table :submissions do |t|
      t.references :solution, null: false
      t.text       :code, null: false

      t.timestamps
    end

    add_foreign_key :submissions, :solutions
  end
end
