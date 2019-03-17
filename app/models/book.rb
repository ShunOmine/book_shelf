class Book < ApplicationRecord
  validates :title, presence: true, length: { maximum: 50 }
  validates :price, presence: true,
            numericality: {only_integer: true,
                           greater_than: 1}
  validates :publish_date, presence: true
  validates :description, presence: true, length: { maximum: 1000 }
  belongs_to :category
  has_one_attached :image
  attribute :new_image

  has_many :reviews, dependent: :destroy
  has_many :users, through: :reviews

  scope :find_newest_books, -> (p) { page(p).per(4).order(publish_date: :desc) }

  before_save do
      self.image = new_image if new_image
  end
end
