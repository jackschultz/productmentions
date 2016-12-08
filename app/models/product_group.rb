class ProductGroup < ApplicationRecord

  has_many :products
  has_many :mentions, through: :products

end
