class CheckCreditCardController < ApplicationController
  def index
    number = credit_card_params[:number]
    purchase_amount = credit_card_params[:purchase_amount].to_f
    code = credit_card_params[:code]
    @credit_card = CreditCard.find_by_number(number)

    if @credit_card
      if @credit_card.valid_code?(code)
        if @credit_card.valid_amount?(purchase_amount)
          render json: {id: @credit_card.id, number: number, current_amount: @credit_card.current_amount, message: 'valid'}
        else
          render json: {id: @credit_card.id, number: number, message: 'invalid amount'}
        end
      else
        render json: {number: number, message: 'invalid code'}, status: 403
      end
    else
      render json: {number: number, message: 'invalid number'}, status: 403
    end
  end

  private

  def credit_card_params
    params.permit(:number, :code, :purchase_amount)
  end
end
