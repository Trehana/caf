SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
    primary.dom_class = 'nav navbar-nav'
    primary.item :news, t('helpers.label.article.nav_name'), admin_articles_path
    primary.item :pages, t('helpers.label.page.nav_name'), admin_pages_path
    primary.item :cafes, t('helpers.label.event.nav_name'), admin_events_path
    primary.item :cafes, t('helpers.label.cafe.nav_name'), admin_cafes_path
    primary.item :cafes, t('helpers.label.art_gallery.nav_name'), admin_art_galleries_path
    primary.item :cafes, t('helpers.label.emerging_artist.nav_name'), admin_emerging_artists_path
    primary.item :profiles, t('helpers.label.profile.nav_name'), admin_profiles_path
    primary.item :galleries, t('helpers.label.gallery.nav_name'), admin_galleries_path
    primary.item :ad_areas, t('helpers.label.ad_area.nav_name'), admin_ad_areas_path
    primary.item :banners, t('helpers.label.banner.nav_name'), admin_banners_path
    primary.item :users, t('helpers.label.user.nav_name'), admin_users_path, if: proc { current_user.can? :manage, User }
    primary.item :galleries, t('helpers.label.common.users.sign_out'), signout_path, method: :delete
  end
end
