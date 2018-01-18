class IssueHistory < ActiveRecord::Base
	belongs_to :book
	belongs_to :member
	validates :issue_date, :return_date, :type_of_book, :book_id, :member_id, presence: true
	validates :type_of_book, inclusion: { in: %w(rent return)}
	validates :book_id, :member_id, numericality: { only_integer: true }
end
