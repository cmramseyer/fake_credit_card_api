require 'rails_helper'

RSpec.describe 'POST /signup', type: :request do
  let(:url) { '/signup' }
  let(:params) do
    {
      user: {
        email: 'user@example.com',
        password: 'password'
      }
    }
  end

  let(:body) { JSON.parse(response.body) }

  context 'when user is unauthenticated' do
    before { post url, params: params, as: :json }

    it 'returns 200' do
      expect(response.status).to eq(200).or eq(201)
    end

    it 'returns a new user' do
      expect(body["user"].present?).to be true
    end
  end

  context 'when user already exists' do
    before do
      User.create(email: 'user@example.com', password: 'password', password_confirmation: 'password')
      post url, params: params, as: :json
    end

    xit 'returns bad request status' do
      expect(body["status"]).to eq 409
    end

    it 'returns validation errors' do
      expect(body["class"]).to include('RecordNotUnique')
    end
  end
end