module ApplicationHelper
  def resource_name
    :user
  end

  def resources
    @resources ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
