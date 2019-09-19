class ApplicationController < ActionController::API
  before_action :authenticate_user!

  def authenticate_user!
    return true if request.headers["authorization"] =="Bearer #{ENV['CREDIT_CARD_API_TOKEN']}"
    false
  end

end
