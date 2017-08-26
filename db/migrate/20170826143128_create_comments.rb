class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.references :submission, null: false
      t.references :user, null: false
      t.text       :body, null: false

      t.timestamps
    end

    add_foreign_key :comments, :submissions
    add_foreign_key :comments, :users
  end
end
