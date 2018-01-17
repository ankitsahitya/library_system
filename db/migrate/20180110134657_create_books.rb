class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.references :library, index: true, foreign_key: true
      t.references :category,  index: true, foreign_key: true
      t.string :name
      t.decimal :price
      t.string :code
      t.string :author
      t.string :publication
      t.string :version
      t.integer :no_of_copies, default: 1
      t.timestamps
    end
  end
end
