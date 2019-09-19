class CreditCardsController < ApplicationController
  def index
    @credit_cards = CreditCard.all
    render json: @credit_cards
  end
end
