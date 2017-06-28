class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.text :body
      t.references :conversation, foreign_key: true
      t.references :user, foreign_key: true
      t.string :attach_file_url
      t.boolean :unread, default: true

      t.timestamps
    end
  end
end
