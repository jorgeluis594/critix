class InvolvedCompany < ApplicationRecord
  #Associations
  belongs_to :company
  belongs_to :game

  #Validations
  validates :developer, :publisher, inclusion: {in: [true, false]}
end
