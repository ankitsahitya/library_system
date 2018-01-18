class Member < ActiveRecord::Base
	has_many :issue_histories
	belongs_to :library
	validates :name, :address, :phone_no, :gender, :code, :validity_date, :library_id, presence: true
	validates :gender, inclusion: { in: %w(male female) }
	validates :phone_no, length: { in: 10..12 }
	validates :library_id, numericality: { only_integer: true }
end
