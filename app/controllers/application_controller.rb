class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :email, :password, :password_confirmation])
  end

  def handle_response(success, success_message, error_view, redirect_path)
    if success
      flash[:notice] = I18n.t(success_message)
      redirect_to redirect_path
    else
      with_error_handling { render error_view, status: :unprocessable_entity }
    end
  end

  def with_error_handling
    yield
  rescue ActiveRecord::RecordNotFound => e
    handle_error(e, I18n.t('errors.record_not_found'), :not_found)
  rescue ActiveRecord::RecordInvalid => e
    handle_error(e, I18n.t('errors.validation_error'), :unprocessable_entity)
  rescue StandardError => e
    handle_error(e, I18n.t('errors.general_error'), :internal_server_error)
  end

  def handle_error(exception, message, status)
    Rails.logger.error("#{message}: #{exception.message}")

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace('flash-container', partial: 'shared/error_messages') }
      format.html { flash[:error] = exception.message }
      format.json { render json: { error: message }, status: status }
    end
  end
end

