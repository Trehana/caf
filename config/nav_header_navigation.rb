# -*- coding: utf-8 -*-
# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
    primary.item :coffee_event, "#{image_tag 'img-coffee-event.png', alt: t('nav.header.coffee_event.coffee_event')}".html_safe + "#{t('nav.header.coffee_event.coffee_event')}", '#' do |coffee_event|
      coffee_event.dom_id = 'coffee_event_sub'
      coffee_event.dom_class = 'sub caffa-2015'
      coffee_event.item :program, t('nav.header.coffee_event.program'), '/caffa-2015/program.html'
      coffee_event.item :sponsors, t('nav.header.coffee_event.sponsors'), '/caffa-2015/sponsors.html'
      coffee_event.item :photo_log, t('nav.header.coffee_event.location_and_floorplan'), '/caffa-2015/location.html'
      coffee_event.item :photo_log, t('nav.header.coffee_event.visitors_info'), '/caffa-2015/visitors-info.html'
      coffee_event.item :photo_log, t('nav.header.coffee_event.vendors_info'), '/caffa-2015/vendors-info.html'
      coffee_event.item :photo_log, t('nav.header.coffee_event.photo_log'), '/caffa-2015/photo-log.html'
    end
    primary.item :coffee_adventure, "#{image_tag 'img-coffee-adventure.png', alt: t('nav.header.coffee_adventure.coffee_adventure')}".html_safe + "#{t('nav.header.coffee_adventure.coffee_adventure')}", '#' do |coffee_adventure|
      coffee_adventure.dom_id = 'coffee_adventure_sub'
      coffee_adventure.dom_class = 'sub coffee-adventure'
      coffee_adventure.item :program, t('nav.header.coffee_adventure.cafe_list'), cafes_path
      coffee_adventure.item :sponsors, t('nav.header.coffee_adventure.coffee_academy'), '/coffee-adventure/coffee-academy.html'
      coffee_adventure.item :photo_log, t('nav.header.coffee_adventure.consultancy'), '/coffee-adventure/consultancy.html'
      coffee_adventure.item :photo_log, t('nav.header.coffee_adventure.supply_network'), '/coffee-adventure/supply-network.html'
    end
    primary.item :art_spot, "#{image_tag 'img-art-spot.png', alt: t('nav.header.art_spot.art_spot')}".html_safe + "#{t('nav.header.art_spot.art_spot')}", '#' do |art_spot|
      art_spot.dom_id = 'art_spot_sub'
      art_spot.dom_class = 'sub art-spot'
      art_spot.item :program, t('nav.header.art_spot.emerging_artists'), emerging_artists_path
      art_spot.item :sponsors, t('nav.header.art_spot.the_galleries'), art_galleries_path
      art_spot.item :photo_log, t('nav.header.art_spot.in_the_studio'), '/art-spot/in-the-studio.html'
    end
    primary.item :the_caffa_store, "#{image_tag 'img-the-caffa-store.png', alt: t('nav.header.the_caffa_store.the_caffa_store')}".html_safe + "#{t('nav.header.the_caffa_store.the_caffa_store')}", 'https://caffaonline.com/'
  end
end
