class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  devise :omniauthable, omniauth_providers: %i[facebook github google_oauth2 gitlab]
  #Associations
  has_many :reviews, dependent: :destroy
  has_many :external_logins, dependent: :destroy
  #Validations
  validates :username, :email, presence: true, uniqueness: true
  validate :has_sixteen_years, unless: :blank_birth_date?

  def self.from_omniauth(auth)
    email = auth.info.email
    email = if email.nil?
                   "#{auth.uid}@mail#{auth.provider}.com"
                 else
                   email
                 end
    user = find_or_create_by(email: email) do |user|
      user.username = auth.info.name.downcase.gsub(/\s/,"") + rand(1..10000).to_s
      user.password = Devise.friendly_token[0, 20]
    end
    user.external_logins.find_or_create_by(provider: auth.provider, uid: auth.uid)
    user
  end


  private
  def has_sixteen_years
    if birth_date > 16.years.ago
      errors.add(:birth_date, "You should have 16 years old to create an account")
    end
  end

  def blank_birth_date?
    self.birth_date.blank?
  end
end
