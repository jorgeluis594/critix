class User < ApplicationRecord
  #Associations
  has_many :reviews

  #Validations
  validates :username, :email, presence: true, uniqueness: true
  validate :has_sixteen_years, unless: :blank_birth_date?

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
