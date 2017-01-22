class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :e_mail, null: false
      t.string :full_name, null: false
      t.string :password, null: false
    end
  end
end
