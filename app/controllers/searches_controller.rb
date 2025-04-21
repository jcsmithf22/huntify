class SearchesController < ApplicationController
  def index
    @searches = Search.all
  end

  def new
    @search = Search.new
  end

  def create
    @search = Search.new(search_params)
    if @search.save
      redirect_to searches_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

    def set_search
      @search = Search.find(params[:id])
    end

    def search_params
      params.expect(search: [ :name, :notes, :keywords, :include_description, :category, :condition, :postal_code, :type, :price_min_cents, :price_max_cents, :best_offer_max_cents ])
    end
end
