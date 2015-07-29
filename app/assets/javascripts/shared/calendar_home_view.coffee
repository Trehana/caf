FC = $.fullCalendar
# a reference to FullCalendar's root namespace
View = FC.views.month
# the class that all views must inherit from
CustomView = undefined
# our subclass
CustomView = View.extend(
  renderHtml: ->
    '<div class="hidden">' + @dayGrid.headHtml() + '<div class="fc-day-grid-container"><div class="fc-day-grid"/></div></div>'

  renderEvents: (events) ->
    $('#calendar-list ul').html('')
    $.each events, (index, event)->
      console.log JSON.stringify(event)
      $('#calendar-list ul').append $(
        "<li>
          <a href='#{event.url}'>
            <div class='calendar-event'>
              <div class='event-img #{event.className.join(' ')}'>
                <img src='#{event.image_url}' alt='#{event.title}'>
              </div>
              <div class='event-date'>
                <span>#{event.event_date}</span>
              </div>
              <div class='event-title'>
                <span>#{event.title}</span>
              </div>
              <div class='event-address'>
                <span>#{event.address}</span>
              </div>
            </div>
          </a>
        </li>"
      )
    return

  destroyEvents: ->
)
FC.views.custom = CustomView
