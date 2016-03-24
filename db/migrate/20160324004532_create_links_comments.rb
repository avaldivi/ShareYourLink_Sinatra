class CreateLinksComments < ActiveRecord::Migration
  def up
    create_table :links_comments do |t|
      t.text :comment
    end
  end

  def down
    drop_table :links_comments
  end
end
