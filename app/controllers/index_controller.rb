class IndexController < ApplicationController
  before_action :authenticate_user!
  # before_action :set_todo, only: [:show, :edit, :update, :destroy]
  before_action :load_allrows, only: [:index]

  def index
  end

  # upgrade account
  def upgrade

    render action: 'upgrade'
  end

  def new_key
    current_user.apikey = SecureRandom.base64.tr('+/=', '')
    current_user.save

    redirect_to edit_user_registration_path
  end

  private
    def load_allrows
      @Quotes = Quote.all
    end

    # Generate a unique API key
    def generate_api_key
      loop do
        token = SecureRandom.base64.tr('+/=', '')
        break token unless User.exists?(apikey: token)
      end
    end
end
