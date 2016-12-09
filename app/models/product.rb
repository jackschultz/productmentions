class Product < ApplicationRecord

  has_many :mentions, dependent: :destroy
  belongs_to :product_group

  def affiliate_url
    self.url + '?tag=pmentions-20'
  end

end
