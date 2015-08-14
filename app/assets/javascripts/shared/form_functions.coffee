$ ->
  $('.submit_on_change').change ->
    $(this).parents("form").submit()
    return

  $('.timepicker').timepicker(
    template: false
    showInputs: false
    minuteStep: 15
    )

window.setTimeout (->
  $('.alert-info, .alert-danger').fadeTo(500, 0).slideUp 300, ->
    $(this).remove()
    return
  return
), 2000
