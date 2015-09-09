$ ->
  $('.btn-filter-toggle').click ->
    $('.filter-seach-form').slideToggle()
    return

  if $('body').width() > 748
    $('ul.' + window.parent_category).prev().trigger('click')

  if typeof gon != 'undefined' && typeof gon.anchor_location != 'undefined'
    window.location.hash = '#' + gon.anchor_location
