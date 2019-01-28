class ApiController < ApplicationController
  before_action :user_auth_by_key, except: [:get_key_by_email]
  before_action :get_user, except: [:get_key_by_email]
  # before_action :check_access
  # /api/v1/tickets_list?key=...
  def tickets_list
    return render json: 'key missing', status: :not_acceptable unless params.has_key?(:key)
    ticketlist = 0

    if @api_current_user.role == 'premium'
      ticketlist = Ticketlist.all.pluck(:sybmol)
    else
      ticketlist = Ticketlist.find_by(for_premium: false)
    end

    render json:  ticketlist, status: :ok
  end

  # api /api/v1/get_key_by_email?email=?
  def get_key_by_email
    render json: {'apikey' => User.where(email: params[:email]).pluck(:apikey)[0], status: :ok} if User.exists?(email: params[:email])
  end

  # api/v1/quotes?key=?&ticket=?&type=(OHLC/close)&from=YYYY-mm-dd&to=YYYY-mm-dd
  def quotes
    check_params = ['key', 'ticket', 'type', 'from', 'to']
    # return render json: params.keys
    return render json: {'Missing keys': "#{check_params - params.keys}"}, status: :ok if (check_params - params.keys).size > 0
    return render json: {'Missing values': "not values"}, status: :ok if params.values.all?(:present?)
    return render json: {'Missing dates': 'wrong format'}, status: :ok if (date_validate(params[:from]).nil? || date_validate(params[:to].nil?))
    date_from = Date.parse(params[:from])
    date_to = Date.parse(params[:to])
    return render json: {'Missing dates': 'wrong format'}, status: :ok if date_from > date_to

    render json: Quote.where(symbol: params[:ticket], datestamp: date_from..date_to).pluck(:open, :high, :low, :close, :symbol, :datestamp) if params[:type] == 'OHLC'
    render json: Quote.where(symbol: params[:ticket], datestamp: date_from..date_to).pluck(:close, :symbol, :datestamp) if params[:type] == 'close'
  end

  # /v1/quotes_for_date?key=user_api-key&type=(OHLC/close)&for_date=YYYY-mm-dd
  def quotes_for_date
    check_params = ['key', 'for_date', 'type']
    # return render json: params.keys
    return render json: {'Missing keys': "#{check_params - params.keys}"}, status: :ok if (check_params - params.keys).size > 0
    return render json: {'Missing values': "not values"}, status: :ok if params.values.all?(:present?)
    return render json: {'Missing dates': 'wrong format'}, status: :ok if (date_validate(params[:for_date]).nil?)
    date_from = Date.parse(params[:for_date])

    render json: Quote.where(datestamp: params[:for_date], symbol: get_tickets(@api_current_user.role)).pluck(:open, :high, :low, :close, :symbol, :datestamp) if params[:type] == 'OHLC'
    render json: Quote.where(datestamp: params[:for_date], symbol: get_tickets(@api_current_user.role)).pluck(:close, :symbol, :datestamp) if params[:type] == 'close'
  end

  private

    def get_user
      @api_current_user = User.find_by(apikey: params[:key])
    end

    def date_validate date
      Date.parse date rescue nil
    end

    def user_auth_by_key
      return render json: 'user not_found', status: :not_found unless User.exists?(apikey: params[:key])
    end

    def get_tickets acc
      ass = [false]
      ass << true if acc == 'premium'
      Ticketlist.where(:for_premium => ass).pluck(:sybmol)
    end
end
