class CategoriesController < ApplicationController

  # before_action :set_category, only: [:show, :edit, :update, :destroy]

  def index 
    @categories = Category.all
  end
  
  def show
    @category = Category.find(params[:id])
  end 

end
