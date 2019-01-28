class ApiController < ApplicationController
  before_action :user_auth_by_key
  before_action :get_user
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

    render json: Quote.where(symbol: params[:ticket], datestamp: for_date).pluck(:open, :high, :low, :close, :symbol, :datestamp) if type == 'OHLC'
    render json: Quote.where(symbol: params[:ticket], datestamp: for_date).pluck(:close, :symbol, :datestamp) if type == 'close'
  end

  # /v1/quotes_for_date?key=user_api-key&type=(OHLC/close)&for_date=YYYY-mm-dd
  def quotes_for_date
    check_params = ['key', 'for_date', 'type']
    # return render json: params.keys
    return render json: {'Missing keys': "#{check_params - params.keys}"}, status: :ok if (check_params - params.keys).size > 0
    return render json: {'Missing values': "not values"}, status: :ok if params.values.all?(:present?)
    return render json: {'Missing dates': 'wrong format'}, status: :ok if (date_validate(params[:for_date]).nil?))
    date_from = Date.parse(params[:for_date])

    render json: Quote.where(datestamp: for_date).pluck(:open, :high, :low, :close, :symbol, :datestamp) if type == 'OHLC'
    render json: Quote.where(datestamp: for_date).pluck(:close, :symbol, :datestamp) if type == 'close'
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
end
