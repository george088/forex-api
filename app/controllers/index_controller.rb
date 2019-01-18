class IndexController < ApplicationController
  before_action :authenticate_user!
  # before_action :set_todo, only: [:show, :edit, :update, :destroy]

  def index

  end
end
