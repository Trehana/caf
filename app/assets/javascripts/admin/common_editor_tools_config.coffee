# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
initialise_edit_tools = ->
  config =
    filebrowserBrowseUrl: gon.assets_path + '?type=pictures'
    filebrowserImageBrowseUrl: gon.assets_path + '?type=pictures'
    filebrowserUploadUrl: gon.assets_path + '?type=pictures'
    filebrowserImageUploadUrl: gon.assets_path + '?type=pictures'
    filebrowserFlashBrowseUrl: gon.assets_path + '?type=attachment_files'
    filebrowserFlashUploadUrl: gon.assets_path + '?type=attachment_files'
    filebrowserImageBrowseLinkUrl: gon.assets_path + '?type=pictures'

  if $('#ck_editor_textarea').length > 0
    config =  if $('#ck_editor_textarea').attr('rel') == 'no-images'
                $.extend(config, window.CKEDITOR_config.without_images)
              else
                $.extend(config, window.CKEDITOR_config.with_images)
    #
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

  if $('div#single_photo_select').length > 0
    photo = undefined
    # The controller expects a class name with _asset to be the data hashe's
    # key. And the form has to have rel field set to that. i.e: 'cover_photo'
    photo_class_data = $('div#single_photo_select').attr('rel') + '_asset[data]'
    photo = new Dropzone('div#single_photo_select',
      url: gon.assets_path
      paramName: photo_class_data
      headers: "X-CSRF-Token" : $('meta[name="csrf-token"]').attr('content')
      )

$(document).ready(initialise_edit_tools)
$(document).on('page:load', initialise_edit_tools)
