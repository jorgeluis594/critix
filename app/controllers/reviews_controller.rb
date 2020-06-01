class ReviewsController < ApplicationController
  def new
    @game = Game.find(params[:game_id])
    @review = Reviews.new
  end

  def create
    @game = Game.find(params[:game_id])
    @review = @game.reviews.new(review_params)
    @review.user = current_user
    if @review.save
      redirect_to game_path(@game)
    else
      flash[:alert] = @review.errors.full_messages
      redirect_to game_path(@game)
    end
  end

  def edit
    @game = Game.find(params[:game_id])
    @review = Review.find(params[:id])
  end

  def update
    @game = Game.find(params[:game_id])
    @review = Review.find(params[:id])
    if @review.update(review_params)
      redirect_to game_path(@game)
    else
      render :edit
    end
  end

  def destroy
    @game = Game.find(params[:game_id])
    @review = @game.reviews.find(params[:id])
    @review.destroy
    redirect_to game_path(@game)
  end

  def review_params
    params.require(:review).permit(:title, :body)
  end
end
