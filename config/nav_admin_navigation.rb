SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
    primary.dom_class = 'nav navbar-nav'
    primary.item :pages, t('helpers.label.page.nav_name'), admin_pages_path
    primary.item :cafes, t('helpers.label.cafe.nav_name'), admin_cafes_path
    primary.item :profiles, t('helpers.label.profile.nav_name'), admin_profiles_path
    primary.item :galleries, t('helpers.label.gallery.nav_name'), admin_galleries_path
    primary.item :users, t('helpers.label.user.nav_name'), admin_users_path, if: proc { current_user.can? :manage, User }
  end
end
