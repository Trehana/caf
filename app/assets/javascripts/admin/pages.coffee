# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
initialise_edit_tools = ->
  if $('#ck_editor_textarea').length > 0
    config =
      toolbar: 'mini'
      filebrowserBrowseUrl: gon.assets_path
      filebrowserImageBrowseUrl: gon.assets_path + '?type=pictures'
      filebrowserUploadUrl: gon.assets_path
      filebrowserImageUploadUrl: gon.assets_path

    ck_editor_textarea = CKEDITOR.replace 'ck_editor_textarea', config

    CKEDITOR.on 'dialogDefinition', (ev) ->
      dialogName = ev.data.name
      dialogDefinition = ev.data.definition
      if dialogName == 'image'
        dialog_definition_content = dialogDefinition.getContents 'Upload'
        dialog_definition_content.elements[0]['id'] = 'picture_asset[data]'
        dialog_definition_content.elements[1]['for'][1] = 'picture_asset[data]'
        action_url = \
          dialog_definition_content.elements[0]['action'] + \
          "&authenticity_token=" + \
          encodeURIComponent($('meta[name="csrf-token"]').attr('content'))
        dialog_definition_content.elements[0]['action'] = action_url
      return

  if $('div#coverphoto_select').length > 0
    coverphoto = undefined
    coverphoto = new Dropzone('div#coverphoto_select',
      url: gon.assets_path
      maxFiles: 1
      paramName: 'cover_photo_asset[data]'
      headers: "X-CSRF-Token" : $('meta[name="csrf-token"]').attr('content')
      )

$(document).ready(initialise_edit_tools)
$(document).on('page:load', initialise_edit_tools)
