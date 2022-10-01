class SearchesController < ApplicationController
  
  def search
    @range = params[:range]
    @word = params[:word]
    @search = params[:search]
    if @range == "User"
      @users = User.search_for(@search, @word)
    else
      @books = Book.search_for(@search, @word)
    end  
  end
  
end
