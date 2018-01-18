class CreateIssueHistories < ActiveRecord::Migration
  def change
    create_table :issue_histories do |t|
			t.references :member, foreign_key: true
      t.references :book, foreign_key: true
      t.date :issue_date
      t.date :return_date
      t.string :type_of_book
      t.integer :no_of_copies, default: 1
      t.timestamps
    end
  end
end
