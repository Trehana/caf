# Add Taxonable to models
module Taxonable
  extend ActiveSupport::Concern

  included do
    has_many :taxons, as: :taxonable
  end

  def taxon_permalinks
    taxons.collect(&:permalink)
  end
end
