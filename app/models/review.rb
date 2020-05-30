class Review < ApplicationRecord
  #Associations
  belongs_to :user, counter_cache: true
  belongs_to :reviewable, polymorphic: true

  #Validations
  validates :title, :body, presence: true
  validates :title, length: { maximum: 40 }, uniqueness: true
end
