class CreateNotes < ActiveRecord::Migration
  def up
    create_table :notes do |t|
      t.string :title
      t.text :body

      t.timestamps
    end
  end

  def down
    drop_table :notes
  end
end
