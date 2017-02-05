class CreateLectures < ActiveRecord::Migration[5.0]
  def change
    create_table :lectures do |t|
      t.string :name, null: false
      t.string :content, null: false
      t.date :date, null: false
    end
  end
end
