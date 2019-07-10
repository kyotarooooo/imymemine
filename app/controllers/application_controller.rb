class ApplicationController < ActionController::Base


  def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.is_a?(Admin)
       admins_admin_mypage_path
    else
       root_path
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :admin
       new_admin_session_path
    else
       new_user_session_path
    end
  end


  def user_login_check
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end

  def admin_login_check
    unless admin_signed_in?
      redirect_to new_admin_session_path
    end
  end

	before_action :configure_permitted_parameters, if: :devise_controller?
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:kanji_name, :kana_name, :user_name, :sex, :height])
  end
end
