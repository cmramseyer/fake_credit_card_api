require 'rails_helper'

RSpec.describe 'POST /login', type: :request do
  let(:user) { users(:user_a) }
  let(:url) { '/login' }
  
  context 'when params are correct' do
    before do
      user.update(password: '12345678', password_confirmation: '12345678')
      post url, params: {user: {email: 'user@a.com', password: '12345678'}}
    end

    it 'returns 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns JTW token in authorization header' do
      expect(response.headers['Authorization']).to be_present
    end

  end

  context 'when login params are incorrect' do
    before { post url }
    
    it 'returns unathorized status' do
      expect(response.status).to eq 401
    end
  end
end

RSpec.describe 'DELETE /logout', type: :request do
  let(:url) { '/logout' }

  it 'returns 204, no content' do
    delete url
    expect(response).to have_http_status(204)
  end
end