class Comment < ApplicationRecord

  belongs_to :subsite
  has_many :mentions

end
