class DeleteColumnPostCommentCount < ActiveRecord::Migration[7.0]
  def up
    remove_column :posts, :comments_count
  end

  def down
    add_column :posts, :comments_count, :integer
  end
end
