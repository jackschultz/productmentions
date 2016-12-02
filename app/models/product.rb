class Product < ApplicationRecord

  has_many :mentions
  belongs_to :product_group

end
