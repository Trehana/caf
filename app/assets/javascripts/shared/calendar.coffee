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
      center: 'prev,today,next',
      right: ''
    defaultView: 'month',
    slotMinutes: 15,

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
      url: '/calendar',
    }],

    timeFormat: '',
    dragOpacity: "0.5"



    eventDrop: (event, dayDelta, minuteDelta, allDay, revertFunc) ->
      updateEvent(event);

    eventResize: (event, dayDelta, minuteDelta, revertFunc) ->
      updateEvent(event);


updateEvent = (the_event) ->
  $.update "/calendar/" + the_event.id,
    event:
      title: the_event.title,
      starts_at: "" + the_event.start,
      ends_at: "" + the_event.end,
      description: the_event.description
