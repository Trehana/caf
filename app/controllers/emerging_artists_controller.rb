# EmergingArtistsController
class EmergingArtistsController < ApplicationController
  include Common
  before_action :set_page_variables, only: [:show]
  before_action :set_body_class
  before_action :set_search_criteria, only: [:index]

  private

  # Set classname for concerns to set the other parameters
  def set_resource_class_name
    @resource_class_name = 'EmergingArtist'
  end

  def set_body_class
    @body_class = 'emerging-artists'
  end

  def set_search_criteria
    @emerging_artist_search = params[:emerging_artist_search] ? EmergingArtistSearch.new(params[:emerging_artist_search]) : EmergingArtistSearch.new

    return unless params[:emerging_artist_search]
    @search_fields = {
      name: @emerging_artist_search.name,
      address: @emerging_artist_search.address,
      suburb: @emerging_artist_search.suburb,
      city: @emerging_artist_search.city,
      location: @emerging_artist_search.location,
      awards: @emerging_artist_search.awards
    }
    @search_order = { "#{@emerging_artist_search.order_by}": :"#{ @emerging_artist_search.order_by == 'name' ? 'asc' : 'desc' }" }
  end
end
