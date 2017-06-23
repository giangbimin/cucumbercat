class CreateChanels < ActiveRecord::Migration[5.1]
  def change
    create_table :chanels do |t|
      t.string :name
      t.string :title
      t.string :avatar_url
      t.string :chanel_type, default: 'self'

      t.timestamps
    end
  end
end
