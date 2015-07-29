class Taxon < ActiveRecord::Base
  acts_as_nested_set

  extend FriendlyId
  friendly_id :permalink, slug_column: :permalink, use: :slugged
  before_create :set_permalink
  after_move :set_and_save_permalink

  belongs_to :taxonable, polymorphic: true

  def set_permalink
    if parent.present?
      self.permalink = [parent.permalink, (permalink.blank? ? taxonable.slug : permalink.split('/').last)].join('/')
    else
      self.permalink = taxonable.slug if permalink.blank?
    end
  end

  def set_and_save_permalink
    set_permalink
    self.save
  end
end
