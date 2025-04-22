class SearchesController < ApplicationController
  before_action :set_search, only: [ :show, :edit, :update, :destroy ]

  def index
    @searches = Search.all
  end

  def show
  end

  def new
    @search = Search.new
  end

  def create
    puts search_params
    @search = Search.new(search_params)
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
      @search = Search.find(params[:id])
    end

    def search_params
      params.expect(search: [ :name, :notes, :keywords, :include_description, :category, :condition, :postal_code, :type, :price_min, :price_max, :best_offer_max ])
    end
end
