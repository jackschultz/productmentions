class Product < ApplicationRecord

  has_many :mentions, dependent: :destroy
  belongs_to :product_group

end
