# -*- coding: utf-8 -*-
# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
    primary.dom_class = 'footer_nav'
    primary.item :first, '' do |first|
      first.dom_class = 'col'
      first.item :coffee_adventure, t('nav.header.the_caffa_store.the_caffa_store'), '/the-caffa-store.html'
      first.item :art_spot, t('nav.header.art_spot.art_spot'), art_galleries_path
      first.item :coffee_adventure, t('nav.header.coffee_adventure.coffee_adventure'), cafes_path
      first.item :coffee_event, t('nav.header.coffee_event.coffee_event'), events_path
    end
    primary.item :second, '' do |second|
      second.dom_class = 'col'
      second.item :about_us, t('nav.header_top.about_us'), '/about-us.html'
      second.item :calendar, t('nav.header_top.calendar'), calendar_path
      second.item :news, t('nav.header_top.news'), articles_path
      second.item :media, t('nav.header_top.media'), '/media.html'
    end
    primary.item :third, '' do |third|
      third.dom_class = 'col'
      third.item :partners, t('nav.header_top.partners'), '/partners.html'
      third.item :contact, t('nav.header_top.contact'), '/contact.html'
    end
  end
end
