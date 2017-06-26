class CreateFriendships < ActiveRecord::Migration[5.1]
  def change
    create_table :friendships do |t|
      t.belongs_to :user
      t.belongs_to :friend
      t.boolean :blocked, default: false
      t.timestamps
    end
  end
end
