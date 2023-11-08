class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :nickname, presence: true
  validates :password,
            format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i, message: 'is invalid. Include both letters and numbers' }
  validates :first_name, presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々]+\z/, message: 'is invalid. Input full-width characers' }
  validates :last_name, presence: true, format: { with: /\A[ぁ-んァ-ヶー-龥々ー]+\z/, message: 'is invalid. Input full-width characers' }
  validates :first_name_kana, presence: true,
                              format: { with: /\A[ァ-ヶー-]+\z/, message: 'is invalid. Input full-width katakana characters' }
  validates :last_name_kana, presence: true,
                             format: { with: /\A[ァ-ヶー-]+\z/, message: 'is invalid. Input full-width katakana characters' }
  validates :birthday, presence: true

  has_many :items
  # has_many :purchases
end
