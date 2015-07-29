$('#subscribe-email').after(
  "<div class='alert alert <%= @alert_class %> subscription-success' role='alert'>
    <%= @notification.html_safe %>
  </div>"
)
$('.subscription-success').fadeOut(7000)
