class IndexController < ApplicationController
  before_action :authenticate_user!
  # before_action :set_todo, only: [:show, :edit, :update, :destroy]
  before_action :load_allrows, only: [:index]

  def index
    
  end

  private
    def load_allrows
      @Quotes = Quote.all
    end
end
