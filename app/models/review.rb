class Review < ApplicationRecord
	validates :rating, presence: true
	belongs_to :restaurant
	belongs_to :user
end