require 'rails_helper'

RSpec.describe CreditCard, type: :model do
  before(:each) do

    @credit_card = credit_cards(:credit_card_12345)
    # current_amount 999.0
    # code 123
  end
  it '#valid_code? false' do
    expect(@credit_card.valid_code?('999')).to be false
  end

  it '#valid_code? true' do
    expect(@credit_card.valid_code?('123')).to be true
  end

  it '#valid_code? true, tolerate code with blanks' do
    expect(@credit_card.valid_code?(' 123 ')).to be true
  end

  it '#valid_amount? true' do
    expect(@credit_card.valid_amount?(999)).to be true
  end

  it '#valid_amount? false' do
    expect(@credit_card.valid_amount?(999.1)).to be false
  end
end
