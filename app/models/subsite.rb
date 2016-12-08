class Subsite < ApplicationRecord

  belongs_to :site
  has_many :comments
  has_many :mentions, through: :comments

end
