class InvolvedCompaniesController < ApplicationController
  def new
    @game = Game.find(params[:game_id])
    @involved_company = @game.involved_companies.new
  end

  def create
    @game = Game.find(params[:game_id])
    @involved_company = @game.involved_companies.new(involved_company_params)
    if @involved_company.save
      redirect_to game_path(@game)
    else
      render :new
    end
  end

  def destroy
    @game = Game.find(params[:game_id])
    @involved_company = @game.involved_companies.find(params[:id])
    @involved_company.destroy
    redirect_to game_path(@game)
  end

  def involved_company_params
    params.require(:involved_company).permit(:company_id, :game_id, :developer, :publisher)
  end
end
