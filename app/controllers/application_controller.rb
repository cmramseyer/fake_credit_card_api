class ApplicationController < ActionController::API
  before_action :authenticate_user!

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ArgumentError, with: :argument_error

  def authenticate_user!
    return true if request.headers["authorization"] =="Bearer #{ENV['CREDIT_CARD_API_TOKEN']}"
    super
  end

  def record_not_found(exception)
    # custom code for record not found
    # ...
    render json: { message: exception.message }, status: 500
  end

  def argument_error(exception)
    # custom code for argument error
    # ...
    render json: { message: exception.message }, status: 500
  end

end
