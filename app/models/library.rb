class Library < ActiveRecord::Base
	has_many :books
	has_many :members
	validates :name, :address, :phone_no, presence: true
	validates :phone_no, length: { in: 10..12 }
end
