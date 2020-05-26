class Game < ApplicationRecord
  has_many :involved_companies
  has_many :companies, through: :involved_companies
  has_and_belongs_to_many :platforms
  has_and_belongs_to_many :genres

  has_many :expansions, class_name: "Game", foreign_key: "parent_id"
  belongs_to :parent, class_name: "Game", optional: true

  has_many :reviews, as: :reviewable

  enum category: { main_game: 0, expansion: 1 }

  validates :name, :category, presence: true
  validates :name, uniqueness: true
  validates :rating, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100, allow_nil: true }
  validate :valid_parent_id, if: :is_expansion

  private

  def valid_parent_id
    unless Game.exists?(self.parent_id)
      errors.add(:parent_id, "Should be a valid game id")
    end
  end

  def is_expansion
    self.expansion?
  end
end
