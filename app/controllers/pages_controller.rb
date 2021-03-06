# PagesController
class PagesController < ApplicationController
  include Common
  before_action :set_page_variables, only: [:show]

  def home
    set_meta_tags title: "#{t('meta_tags.title')}"
    @resource = Page.find('home')
    @body_class = 'homepage'
    gon.push calendar_tag: ''
    set_page_variables
  end

  def subscribe
    begin
      gb = Gibbon::API.new(Settings.gibbon[:api_key])
      gb.lists.subscribe({id: Settings.gibbon[:list_id], email: {email: params[:email]}, double_optin: false})
    rescue Gibbon::MailChimpError => e
      @notification = "<strong>ERROR:</strong> #{e}"
      @alert_class = 'alert-danger'
    else
      @notification = '<strong>Thank you!</strong> Your subscription received.'
      @alert_class = 'alert-success'
    end
  end

  private

  # Set classname for concerns to set the other parameters
  def set_resource_class_name
    @resource_class_name = 'Page'
  end
end
