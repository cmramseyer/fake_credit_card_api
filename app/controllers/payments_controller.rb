class PaymentsController < ApplicationController

  def index
    @credit_card = CreditCard.find(params[:credit_card_id])
    render json: @credit_card.payments
  end

  def create
    service = Service::MakeAPayment.new(
      credit_card_id: params[:credit_card_id],
      amount: params[:amount]
      )
    if service.run
      render json: service.payment
    else
      render json: { message: service.exception.message }, status: 500
    end
  end

end
