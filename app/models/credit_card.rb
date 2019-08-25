class CreditCard < ApplicationRecord

  def valid_code?(_code)
    code == _code.strip
  end

  def valid_amount?(purchase_amount)
    purchase_amount.to_f <= current_amount
  end
end
