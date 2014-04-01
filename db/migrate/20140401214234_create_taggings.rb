class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.integer :todo_id, :tag_idodo
      
      t.timestamps
    end
  end
end
