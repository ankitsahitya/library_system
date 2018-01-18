class Book < ActiveRecord::Base
  belongs_to :library
  belongs_to :category
  has_many :issue_histories
  validates :name, :price, :code, :author, :publication, :version, :library_id, :category_id, presence: true
  validates :price, numericality: { only_decimal: true }
  validates :library_id, :category_id, :no_of_copies, numericality: { only_integer: true }
end