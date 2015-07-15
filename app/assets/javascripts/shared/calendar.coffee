$(document).ready ->
  currentDate = new Date()
  monthNames = [
                  "January", "February", "March", "April",
                  "May", "June", "July", "August", "September",
                  "October", "November", "December"
                ]
  currentMonthName = monthNames[currentDate.getMonth()]

  $('#calendar_caffa').fullCalendar
    editable: false,
    header:
      left: '',
      center: '',
      right: ''
    defaultView: 'month',
    slotMinutes: 15,
    titleFormat: 'M'

    dayNamesShort: ['S', 'M', 'T', 'W', 'T', 'F', 'S']
    firstDay: 1
    aspectRatio: 1.2
    buttonText:
      today:    currentMonthName,
      month:    'month',
      week:     'week',
      day:      'day',
      prev: 'Previous'

    eventSources: [{
      url: '/calendar'
    }],

    timeFormat: '',
    dragOpacity: "0.5"

    viewRender: (view, element)->
      month_id = parseInt(view.title) - 1

      get_month = (m_id)->
        if m_id > 11
          m_id = 0
        if m_id < 0
          m_id = 11
        m_id

      prev_month_id = get_month(month_id - 1)
      next_month_id = get_month(month_id + 1)

      $('#active-month').html(monthNames[month_id])
      $('#calendar-prev').html(monthNames[prev_month_id])
      $('#calendar-next').html(monthNames[next_month_id])



  $('#calendar-prev').click ->
    $('#calendar_caffa').fullCalendar 'prev'
    return
  $('#calendar-next').click ->
    $('#calendar_caffa').fullCalendar 'next'
    return


    # eventDrop: (event, dayDelta, minuteDelta, allDay, revertFunc) ->
    #   updateEvent(event);
    #
    # eventResize: (event, dayDelta, minuteDelta, revertFunc) ->
    #   updateEvent(event);


# updateEvent = (the_event) ->
#   $.update "/calendar/" + the_event.id,
#     event:
#       title: the_event.title,
#       starts_at: "" + the_event.start,
#       ends_at: "" + the_event.end,
#       description: the_event.description
