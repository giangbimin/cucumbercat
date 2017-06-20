class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :full_name
      t.string :gender
      t.string :avatar_url
      t.string :password_digest

      t.timestamps
    end
  end
end
