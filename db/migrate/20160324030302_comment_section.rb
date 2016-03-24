class CommentSection < ActiveRecord::Migration
  def up
    create_table :comment_section do |t|
      t.text :new_comment
    end
  end

  def down
    drop_table :comment_section
  end
end
