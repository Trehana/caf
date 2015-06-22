$ ->
  $('.submit_on_change').change ->
    $(this).parents("form").submit()
    return
