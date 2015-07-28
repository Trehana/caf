# -*- coding: utf-8 -*-
# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
    primary.item :about_us, t('nav.header_top.about_us'), '/about-us.html'
    primary.item :calendar, t('nav.header_top.calendar'), calendar_path
    primary.item :news, t('nav.header_top.news'), articles_path
    primary.item :media, t('nav.header_top.media'), '/media.html'
    primary.item :partners, t('nav.header_top.partners'), '/partners.html'
    primary.item :contact, t('nav.header_top.contact'), '/contact.html'
  end
end
