# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
create_ckeditor_window = ->
  if $('#ck_editor_textarea').length > 0
    config = toolbar: 'mini'
    ck_editor_textarea = CKEDITOR.replace 'ck_editor_textarea', config

  coverphoto = undefined
  coverphoto = new Dropzone('div#coverphoto_select',
    url: '/admin/pages/'
    maxFiles: 1)

$(document).ready(create_ckeditor_window)
$(document).on('page:load', create_ckeditor_window)
