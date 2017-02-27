class AddCategorieToPosts < ActiveRecord::Migration[5.0]
  def change
    add_reference :posts, :categories, foreign_key: true
  end
end
