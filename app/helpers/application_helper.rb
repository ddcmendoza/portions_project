module ApplicationHelper
  def resource_name
    :user
  end

  def resources
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
