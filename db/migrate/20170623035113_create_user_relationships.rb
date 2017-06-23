class CreateUserRelationships < ActiveRecord::Migration[5.1]
  def change
    create_table :user_relationships do |t|
      t.belongs_to :user, foreign_key: true
      t.string :friend_id
      t.string :status

      t.timestamps
    end
  end
end
