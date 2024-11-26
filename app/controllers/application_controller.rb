class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

   # ログイン後のリダイレクト先
   def after_sign_in_path_for(resource)
    mypage_path
  end

  # サインアップ後のリダイレクト先
  def after_sign_up_path_for(resource)
    mypage_path
  end

  # ログアウト後のリダイレクト先
  def after_sign_out_path_for(resource_or_scope)
    about_path # アバウトページの名前付きルートヘルパー
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

end
