class Api::FoodsController < ApplicationController
  def index
    @foods = []
    if params[:q] && params[:q] != ''
      @foods = Fitbit::Food.search(current_user, params[:q])
    end
  end
end