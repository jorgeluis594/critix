class ChangeReviewCountToReview < ActiveRecord::Migration[6.0]
  def up
    change_column_default :users, :review_count, 0
  end

  def down
    change_column_default :users, :review_count, nil
  end
end
