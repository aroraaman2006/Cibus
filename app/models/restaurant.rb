class Restaurant < ApplicationRecord
  validates :name, presence: true
  validates :state, presence: true
  validates :city, presence: true
  validates :address, presence: true

  has_and_belongs_to_many :categories
  has_many :reviews
  belongs_to :user

  has_attached_file :restaurant_img, styles: { restaurant_index: "250x350>", restaurant_show: "325x475>" }, default_url: "/images/missing.png"
  validates_attachment_content_type :restaurant_img, content_type: /\Aimage\/.*\z/
end
