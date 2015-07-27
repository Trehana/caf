# Awards for artists, cafes or anything with address
class Award < ActiveRecord::Base
  belongs_to :addressable, polymorphic: true

  def to_s
    "#{name} - #{year}"
  end

  def to_html
    "<span class='award_name'>#{name}</span> - <span class='award_year'>#{year}</p>"
  end


  def to_json
    {
      name: name,
      year: year
    }
  end
end
