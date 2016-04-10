class CreateComments < ActiveRecord::Migration
  def up
    create_table :comments do |t|
      t.string :author
      t.text :comment, :null => false
    end
    add_reference :comments, :link
  end

  def down
    drop_table :links
  end
end
