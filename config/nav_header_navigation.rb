# -*- coding: utf-8 -*-
# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
    primary.item :coffee_event, "#{image_tag 'img-coffee-event.png', alt: t('nav.header.coffee_event.coffee_event')}".html_safe + "#{t('nav.header.coffee_event.coffee_event')}", '#' do |coffee_event|
      coffee_event.dom_id = 'coffee_event'
      coffee_event.dom_class = 'sub'
      coffee_event.item :program, t('nav.header.coffee_event.program'), '#'
      coffee_event.item :sponsors, t('nav.header.coffee_event.sponsors'), '#'
      coffee_event.item :photo_log, t('nav.header.coffee_event.photo_log'), '#'
    end
    primary.item :coffee_adventure, "#{image_tag 'img-coffee-adventure.png', alt: t('nav.header.coffee_adventure.coffee_adventure')}".html_safe + "#{t('nav.header.coffee_adventure.coffee_adventure')}", '#' do |coffee_adventure|
      coffee_adventure.dom_id = 'coffee_event'
      coffee_adventure.dom_class = 'sub'
      coffee_adventure.item :program, t('nav.header.coffee_adventure.cafe_list'), '#'
      coffee_adventure.item :sponsors, t('nav.header.coffee_adventure.coffee_academy'), '#'
      coffee_adventure.item :photo_log, t('nav.header.coffee_adventure.consultancy'), '#'
      coffee_adventure.item :photo_log, t('nav.header.coffee_adventure.supply_network'), '#'
    end
    primary.item :art_spot, "#{image_tag 'img-art-spot.png', alt: t('nav.header.art_spot.art_spot')}".html_safe + "#{t('nav.header.art_spot.art_spot')}", '#' do |art_spot|
      art_spot.dom_id = 'art_spot'
      art_spot.dom_class = 'sub'
      art_spot.item :program, t('nav.header.art_spot.emerging_artists'), '#'
      art_spot.item :sponsors, t('nav.header.art_spot.the_galleries'), '#'
      art_spot.item :photo_log, t('nav.header.art_spot.in_the_studio'), '#'
    end
    primary.item :coffee_adventure, "#{image_tag 'img-the-caffa-store.png', alt: t('nav.header.the_caffa_store.the_caffa_store')}".html_safe + "#{t('nav.header.the_caffa_store.the_caffa_store')}", '#'
  end
end
