class Review < ApplicationRecord
  belongs_to :user
  belongs_to :reviewable, polymorphic: true

  after_create :add_review_count
  after_destroy :reduce_review_count

  private
  def add_review_count
    review_count = self.user.review_count
    self.user.update(review_count: review_count + 1)
  end

  def reduce_review_count
    review_count = self.user.review_count
    self.user.update(review_count: review_count - 1)
  end
end
