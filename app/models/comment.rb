class Comment < ApplicationRecord

  belongs_to :subsite
  has_many :mentions, dependent: :destroy

  def self.search(term)
    where("lower(thread_title) LIKE ?", "%#{term.downcase}%")
  end

  self.per_page = 20

end
