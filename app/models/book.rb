class Book < ApplicationRecord
  is_impressionable
 
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :favorited_users , through: :favorites, source: :user
  has_many :book_comments, dependent: :destroy

  validates :title , presence: true
  validates :body , length: {maximum: 200}, presence: true

  def self.looks(searches,words)
    if searches == "perfect_match"
      @book = Book.where("title LIKE ?" , "#{words}")
      @book = Book.where("body LIKE ?" , "#{words}")
    elsif searches == "forword_match"
      @book = Book.where("title LIKE ?" , "#{words}%")
      @book = Book.where("body LIKE ?" , "#{words}%")
    elsif searches == "backword_match"
      @book = Book.where("title LIKE ?" , "%#{words}")
      @book = Book.where("body LIKE ?" , "%#{words}")
    else
      @book = Book.where("title LIKE ?" , "%#{words}%")
      @book = Book.where("body LIKE ?" , "%#{words}%")
    end
  end
end
