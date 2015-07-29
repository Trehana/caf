$ ->
  $('.btn-filter-toggle').click ->
    $('.filter-seach-form').slideToggle()
    return

  $('ul.' + window.parent_category).prev().trigger('click')
