# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:about]
  before_action :configure_permitted_parameters, if: :devise_controller?

  def index; end

  def about; end

  protected

  def after_sign_out_path_for(_scope)
    new_user_session_path
  end

  def configure_permitted_parameters
    added_attrs = %i[username email password password_confirmation remember_me]
    devise_parameter_sanitizer.permit(:sign_up, keys: [added_attrs])
    devise_parameter_sanitizer.permit(:sign_in, keys: %i[login password])
    devise_parameter_sanitizer.permit(:account_update, keys: [added_attrs, :avatar])
  end
end
