module Service
  class MakeAPayment

    attr_reader :payment, :exception

    def initialize(credit_card_id:, amount:)
      @credit_card = CreditCard.find(credit_card_id)
      @amount = Float(amount, exception: true)
    end

    def run
      # multiple updates and creates should be wrapped in a transaction
      ActiveRecord::Base.transaction do

        check_amount
        @new_amount = @credit_card.current_amount - @amount
        # let's create the payment before the current_amount update
        # in the credit card
        create_payment
        update_credit_card
      end
      true
    rescue Exception => exception
      @exception = exception
      # here I would send the exception to Sentry/Rollbar, etc
      false
    end

    private

    def check_amount
      raise Error::InsufficientFunds.new "Insufficient funds" unless @credit_card.valid_amount?(@amount)
    end

    def update_credit_card
      @credit_card.update_attributes(current_amount: @new_amount)
    end

    def create_payment
      @payment = Payment.create!(
        credit_card: @credit_card,
        amount_before: @credit_card.current_amount,
        payment_amount: @amount,
        current_amount: @new_amount
        )
    end
  end
end