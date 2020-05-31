class Company < ApplicationRecord
  #Scopes
  scope :developer, -> { where('involved_companies.developer = ?', true) }
  scope :publisher, -> { where('involved_companies.publisher = ?', true) }

  #Associations
  has_many :involved_companies, dependent: :destroy
  has_many :games, through: :involved_companies
  has_many :reviews, as: :reviewable, dependent: :destroy
  
  #Validations
  validates :name, :country, presence: true
  validates :name, uniqueness: true
end
