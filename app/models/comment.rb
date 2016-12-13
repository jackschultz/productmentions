class Comment < ApplicationRecord

  belongs_to :subsite
  has_many :mentions, dependent: :destroy

  def self.search(term)
    where("thread_title LIKE ?", "%#{term}%")
  end

  self.per_page = 20

end
