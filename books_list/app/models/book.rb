class Book < ApplicationRecord
  has_many :book_genres
  has_many :genres, through: :book_genres
  before_create :set_approved
  before_save :set_keywords
  scope :approved, -> {where(approved: true)}
  scope :search, ->(keyword) { where('keywords LIKE ?', "%#{keyword.downcase}%") if keyword.present? }
  scope :filter, ->(name) {
    joins(:genres).where('genres.name = ?', name) if name.present?
  }
    validates_inclusion_of :rating, in: 1..5
    validates :rating, numericality: { only_integer: true }
  protected

  def set_keywords
    self.keywords = [title, author, description].map(&:downcase).join(' ')
  end
  def set_approved
    self.approved ||= false
  end
end
