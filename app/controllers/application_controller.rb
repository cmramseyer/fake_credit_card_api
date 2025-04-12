class ApplicationController < ActionController::API
  before_action :authenticate_user!

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordNotUnique, with: :record_not_unique
  rescue_from ArgumentError, with: :argument_error
  rescue_from StandardError, with: :standard_error

  def authenticate_user!
    return true if request.headers["authorization"] =="Bearer #{ENV['CREDIT_CARD_API_TOKEN']}"
    super
  end

  def record_not_found(exception)
    # custom code for record not found
    # ...
    render json: { message: exception.message }, status: 500
  end

  def record_not_unique(exception)
    render json: { message: exception.message, error: 'Record Not Unique' }, status: 409
  end

  def argument_error(exception)
    # custom code for argument error
    # ...
    render json: { message: exception.message }, status: 500
  end

  def standard_error(exception)
    render json: { message: exception.message, class: exception.class.name, backtrace: exception.backtrace }, status: 500
  end

  def route_not_found
    render json: { error: 'Not Found' }, status: :not_found
  end

end
