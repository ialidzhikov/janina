class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string  :full_name, null: false
      t.integer :faculty_number, null: false
      t.string  :e_mail, null: false
      t.string  :password_digest, null: false
      t.boolean :admin, null: false, default: false

      t.string :photo
      t.string :about
      t.string :github

      t.index :e_mail,         unique: true
      t.index :faculty_number, unique: true
    end
  end
end
