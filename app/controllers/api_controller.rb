class ApiController < ApplicationController

  # /api/v1/tickets_list?key=...
  def tickets_list
    key = params[:key]

    api_current_user = User.find_by(api_key: key)
    ticketlist = 0

    if api_current_user.role == 'premium'
      ticketlist = Ticketlist.all.pluck(:role)
    else
      ticketlist = Ticketlist.find_by(for_premium: '0').pluck(:role)
    end

    render json: {'tickets' : ticketlist}, status: :ok
  end

  # api/v1/quotes?key=?&ticket=?&type=(OHLC/close)&from=YYYY-mm-dd&to=YYYY-mm-dd
  def quotes
    params.values.all?(:present?)
  end
end
