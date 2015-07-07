class CategoriesController < ApplicationController

  # before_action :set_category, only: [:show, :edit, :update, :destroy]

  def show
    @category = Category.find(params[:id])
  end 

  # private
  #   # Use callbacks to share common setup or constraints between actions.
  #   def set_post
  #     @post = Category.find(params[:id])
  #   end
  # end

end
