class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :title
      t.string :experience
      t.float :rating
      t.integer :user_id
      t.integer :restaurant_id
    end
  end
end
