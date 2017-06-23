class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :chanel, foreign_key: true
      t.text :body
      t.boolean :read_status

      t.timestamps
    end
  end
end
