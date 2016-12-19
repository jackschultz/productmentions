class Mention < ApplicationRecord

  belongs_to :product
  belongs_to :comment

  self.per_page = 30

end
