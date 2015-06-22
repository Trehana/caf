$(".dropzone_thumb").on "ajax:success", "a.delete_dropzone_thumb", (event, data, status, xhr) ->
  alert 'event happening....'
  $(event.target).parent().fadeOut "slow", () ->
    $(this).remove()
