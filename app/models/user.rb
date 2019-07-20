class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :coordinates
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
  attachment :profile_image


  validates :kanji_name, format: { with: /\A[ぁ-んァ-ン一-龥]/ }
  validates :kana_name, format: { with: /\A[ァ-ヶー－]+\z/ }
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }

  def self.search(search)
    if search
      User.where(['user_name LIKE ?', "%#{search}%"])
    else
      User.all
    end
  end

end



