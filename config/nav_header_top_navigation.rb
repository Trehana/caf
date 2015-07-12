# -*- coding: utf-8 -*-
# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
    primary.item :about_us, t('nav.header_top.about_us'), '#'
    primary.item :calendar, t('nav.header_top.calendar'), '#'
    primary.item :news, t('nav.header_top.news'), articles_path
    primary.item :media, t('nav.header_top.media'), '#'
    primary.item :partners, t('nav.header_top.partners'), '#'
    primary.item :contact, t('nav.header_top.contact'), page_url(id: 'contact')
  end
end
