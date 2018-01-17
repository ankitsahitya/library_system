class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
    	t.references :library, foreign_key: true
    	t.string :name
    	t.string :address
    	t.bigint :phone_no
    	t.integer :gender
    	t.integer :code
    	t.date :validity_date
    	t.boolean :is_author, default: false
      t.timestamps
    end
  end
end
