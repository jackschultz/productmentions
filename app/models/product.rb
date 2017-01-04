class Product < ApplicationRecord

  has_many :mentions, dependent: :destroy
  belongs_to :product_group
  delegate :comment, :to => :mentions

  def self.search(term)
    where("lower(title) LIKE ?", "%#{term.downcase}%")
  end

  self.per_page = 20

end
