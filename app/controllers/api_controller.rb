class ApiController < ApplicationController
  before_action :get_user

  # /api/v1/tickets_list?key=...
  def tickets_list
    return render json: 'key missing', status: :not_acceptable unless params.has_key?(:key)
    return render json: 'user not_found', status: :not_found unless User.exists?(apikey: params[:key])

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
    check_params = [:key, :ticket, :type, :from, :to]

    return render json: {'Missing keys': "#{check_params - params.keys}"}, status: :not_acceptable if (check_params - params.keys).size > 0
    return render json: {'Missing values': "not values"}, status: :not_acceptable unless params.values.all?(:present?)
    return render json: {'Missing dates': 'wrong format'}, status: :not_acceptable if (date_validate(params[:from]).nil? || date_validate(params[:to].nil?))
    date_from = Date.parse(params[:from])
    date_to = Date.parse(params[:to])

    return render json: {'Missing dates': 'wrong format'}, status: :not_acceptable if date_from > date_to

    Quotes.where(days: {:date => date_from..date_to}, symbol: params[:ticket]).pluck(:open, :high, :low, :close, :symbol)

  end

  private

    def get_user
      @api_current_user = User.find_by(apikey: params[:key])
    end

    def date_validate date
      Date.parse date rescue nil
    end
end
