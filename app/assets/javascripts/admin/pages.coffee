# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
create_ckeditor_window = ->
  if $('#ck_editor_textarea').length > 0
    config = toolbar: 'mini'
    ck_editor_textarea = CKEDITOR.replace 'ck_editor_textarea', config

  if $('div#coverphoto_select').length > 0
    coverphoto = undefined
    coverphoto = new Dropzone('div#coverphoto_select',
      url: gon.asset_submit_path
      maxFiles: 1
      paramName: 'cover_photo_asset[data]'
      headers: "X-CSRF-Token" : $('meta[name="csrf-token"]').attr('content')
      )

$(document).ready(create_ckeditor_window)
$(document).on('page:load', create_ckeditor_window)
