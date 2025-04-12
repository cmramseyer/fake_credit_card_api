require 'rails_helper'

RSpec.describe CheckCreditCardController, type: :controller do

  let(:token) { "1234TOKEN" }

  before do
    ENV["CREDIT_CARD_API_TOKEN"] = token
    @request.headers['Authorization'] = "Bearer #{token}"
  end

  it "returns http success" do
    get :index, params: {number: '12345', code: '123'}, as: :json
    expect(response).to have_http_status(:success)
  end

  it "valid number, code and permitted purchase" do
    get :index, params: {number: '12345', code: '123', purchase_amount: '100'}, as: :json
    json = JSON.parse(response.body)
    expect(json["number"]).to eq('12345')
    expect(json["current_amount"]).to eq(999.0)
    expect(json["message"]).to eq('valid')
  end

  it "invalid number" do
    get :index, params: {number: '1234', code: '123', purchase_amount: '100'}, as: :json
    json = JSON.parse(response.body)
    expect(json["number"]).to eq('1234')
    expect(json["message"]).to eq('invalid number')
  end

  it "invalid code" do
    get :index, params: {number: '12345', code: '124', purchase_amount: '100'}, as: :json
    json = JSON.parse(response.body)
    expect(json["number"]).to eq('12345')
    expect(json["message"]).to eq('invalid code')
  end

  it "invalid amount" do
    get :index, params: {number: '12345', code: '123', purchase_amount: '999.1'}, as: :json
    json = JSON.parse(response.body)
    expect(json["number"]).to eq('12345')
    expect(json["message"]).to eq('invalid amount')
  end

end
