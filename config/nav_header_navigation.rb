# -*- coding: utf-8 -*-
# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
    primary.item :coffee_event, "#{image_tag 'img-coffee-event.png', alt: t('nav.header.coffee_event.coffee_event')}".html_safe + "#{t('nav.header.coffee_event.coffee_event')}", '#' do |coffee_event|
      coffee_event.dom_id = 'coffee_event_sub'
      coffee_event.dom_class = 'sub'
      coffee_event.item :program, t('nav.header.coffee_event.program'), page_url(id: 'program')
      coffee_event.item :sponsors, t('nav.header.coffee_event.sponsors'), page_url(id: 'sponsors')
      coffee_event.item :photo_log, t('nav.header.coffee_event.location_and_floorplan'), page_url(id: 'location-and-floorplan')
      coffee_event.item :photo_log, t('nav.header.coffee_event.visitors_info'), page_url(id: 'visitors-info')
      coffee_event.item :photo_log, t('nav.header.coffee_event.vendors_info'), page_url(id: 'vendors-info')
      coffee_event.item :photo_log, t('nav.header.coffee_event.photo_log'), page_url(id: 'photo-log')
    end
    primary.item :coffee_adventure, "#{image_tag 'img-coffee-adventure.png', alt: t('nav.header.coffee_adventure.coffee_adventure')}".html_safe + "#{t('nav.header.coffee_adventure.coffee_adventure')}", '#' do |coffee_adventure|
      coffee_adventure.dom_id = 'coffee_adventure_sub'
      coffee_adventure.dom_class = 'sub'
      coffee_adventure.item :program, t('nav.header.coffee_adventure.cafe_list'), cafes_path
      coffee_adventure.item :sponsors, t('nav.header.coffee_adventure.coffee_academy'), page_url(id: 'coffee-academy')
      coffee_adventure.item :photo_log, t('nav.header.coffee_adventure.consultancy'), page_url(id: 'consultancy')
      coffee_adventure.item :photo_log, t('nav.header.coffee_adventure.supply_network'), page_url(id: 'supply-network')
    end
    primary.item :art_spot, "#{image_tag 'img-art-spot.png', alt: t('nav.header.art_spot.art_spot')}".html_safe + "#{t('nav.header.art_spot.art_spot')}", '#' do |art_spot|
      art_spot.dom_id = 'art_spot_sub'
      art_spot.dom_class = 'sub'
      art_spot.item :program, t('nav.header.art_spot.emerging_artists'), emerging_artists_path
      art_spot.item :sponsors, t('nav.header.art_spot.the_galleries'), art_galleries_path
      art_spot.item :photo_log, t('nav.header.art_spot.in_the_studio'), page_url(id: 'in-the-studio')
    end
    primary.item :the_caffa_store, "#{image_tag 'img-the-caffa-store.png', alt: t('nav.header.the_caffa_store.the_caffa_store')}".html_safe + "#{t('nav.header.the_caffa_store.the_caffa_store')}", page_url(id: 'the-caffa-store')
  end
end
