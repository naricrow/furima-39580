class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :nickname, presence: true
  validates :password,
            format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i, message: 'は半角英字と半角文字の両方を含めて設定してください' }
  validates :first_name, presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々]+\z/, message: 'は全角文字で入力してください' }
  validates :last_name, presence: true, format: { with: /\A[ぁ-んァ-ヶー-龥々ー]+\z/, message: 'は全角文字で入力してください' }
  validates :first_name_kana, presence: true,
                              format: { with: /\A[ァ-ヶー-]+\z/, message: 'は全角カナで入力してください' }
  validates :last_name_kana, presence: true,
                             format: { with: /\A[ァ-ヶー-]+\z/, message: 'は全角カナで入力してください' }
  validates :birthday, presence: true

  has_many :items
  # has_many :purchases
end
