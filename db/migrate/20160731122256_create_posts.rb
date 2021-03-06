class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.integer :initNum, default: 0
      t.integer :user_id
      t.integer :hit, default: 0
      t.integer :reconum, default: 0
      t.boolean :grand, default: true

      t.timestamps
    end
    add_index :posts, :user_id
  end
end
