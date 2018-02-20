class Product < ApplicationRecord
  mount_uploader :image, ImageUploader
  mount_uploader :image1, ImageUploader
  mount_uploader :image2, ImageUploader
  mount_uploader :image3, ImageUploader
  has_many :order_items, dependent: :destroy
  belongs_to :provider
  has_many :sub_categories
  has_many :categories, through: :sub_categories
  scope :search, ->q{where "name LIKE '%#{q}%'"}

  class << self
    def get_product_of_category category_id
      joins(:sub_categories).where("sub_categories.category_id = ?", category_id).order(price: :asc).all
    end
  end
end
