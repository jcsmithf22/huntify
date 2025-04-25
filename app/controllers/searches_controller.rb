class SearchesController < ApplicationController
  before_action :set_search, only: [ :show, :edit, :update, :destroy ]

  def index
    @searches = Current.user.searches.all
  end

  def show
  end

  def new
    @search = Current.user.searches.new(include_description: true)
  end

  def create
    @search = Current.user.searches.new(search_params)
    if @search.save
      redirect_to searches_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @search.update(search_params)
      redirect_to searches_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @search.destroy
    redirect_to searches_path
  end

  private

    def set_search
      @search = Current.user.searches.find(params[:id])
    end

    def search_params
      params.expect(search: [ :name, :notes, :keywords, :include_description, :category, :condition, :postal_code, :listing_type, :price_min, :price_max, :best_offer_max ])
    end
end
