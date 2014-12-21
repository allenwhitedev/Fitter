class CreateFeats < ActiveRecord::Migration
  def change
    create_table :feats do |t|
      t.references :user, index: true
      t.string :picture
      t.string :title
      t.text :content

      t.timestamps null: false
    end
    add_foreign_key :feats, :users
  end
end
