class PlatformsController < ApplicationController
  def index
    @platforms = Platform.all.order(:name)
  end
end
