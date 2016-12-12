class Mention < ApplicationRecord

  belongs_to :product, counter_cache: true
  belongs_to :comment, counter_cache: true

  self.per_page = 20

end
