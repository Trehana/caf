$ ->
  $('.submit_on_change').change ->
    $(this).parents("form").submit()
    return

  $('.timepicker').timepicker(
    template: false
    showInputs: false
    minuteStep: 15
    )
