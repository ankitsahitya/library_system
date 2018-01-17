class CreateLibraries < ActiveRecord::Migration
  def change
    create_table :libraries do |t|
    	t.string :name
    	t.string :address
    	t.bigint :phone_no
      t.timestamps
    end
  end
end
