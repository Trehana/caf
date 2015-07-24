# Editor tools config
initialise_edit_tools = ->
  config =
    filebrowserBrowseUrl: gon.assets_path + '?type=pictures'
    filebrowserImageBrowseUrl: gon.assets_path + '?type=pictures'
    filebrowserUploadUrl: gon.assets_path + '?type=pictures'
    filebrowserImageUploadUrl: gon.assets_path + '?type=pictures'
    filebrowserFlashBrowseUrl: gon.assets_path + '?type=attachment_files'
    filebrowserFlashUploadUrl: gon.assets_path + '?type=attachment_files'
    filebrowserImageBrowseLinkUrl: gon.assets_path + '?type=pictures'

  # Iterate through elements with ck_editor_textarea class and
  # CKEditor editor
  $.each $('.ck_editor_textarea'), (index, editor_area)->
    console.log editor_area
    config =
      if $(editor_area).attr('rel') == 'no-images'
        $.extend(config, window.CKEDITOR_config.without_images)
      else
        $.extend(config, window.CKEDITOR_config.with_images)

    window[$(editor_area).attr('id')] = CKEDITOR.replace $(editor_area).attr('id'), config

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

  if $('div#photo_select').length > 0
    photo = undefined
    # The controller expects a class name with _asset to be the data hashe's
    # key. And the form has to have rel field set to that. i.e: 'cover_photo'
    photo_class_data = $('div#photo_select').attr('rel') + '_asset[data]'
    photo = new Dropzone('div#photo_select',
      url: gon.assets_path
      paramName: photo_class_data
      headers: "X-CSRF-Token" : $('meta[name="csrf-token"]').attr('content')
      )
    photo.on 'success', (file, responseText) ->
      responseText = responseText
      $('.dz-preview').remove()
      $( "#photo_select" ).empty();
      $('#photo_select').append '<div class=\'dropzone_thumb\'><a class=\'delete_dropzone_thumb\' id=\'my_link\' href=\'\' data-method=\'delete\' rel=\'nofollow\' data-remote=\'true\' data-confirm=\'Are you sure, you want to delete?\'><img id=\'my_img\' alt=\'\' src=\'\' title=\'Delete\'></a></div>'
      $('#my_img').attr 'src', responseText.asset.url_thumb
      $('#my_img').attr 'alt', responseText.asset.filename
      address = window.location.toString()
      arr = address.split('/')
      new_address = '/' + arr[3] + '/' + arr[4] + '/' + arr[5] + '/cover_photo/' + responseText.asset.id + '.json'
      $('#my_link').attr 'href', new_address

    $('.delete_dropzone_thumb').click (event) ->
      event.preventDefault()
      a_href = $(this).attr('href')
      if confirm('Are you sure, you want to delete?')
        $.ajax
          url: a_href
          type: 'DELETE'
          success: (result) ->
            $('.dropzone_thumb').hide()
            return
      else
        return false
      return
    $(document).ajaxStart ->
      $('.dz-default dz-message').show()
      $('#my_img').hide()
      $( "#photo_select" ).empty();
      $('#photo_select').append '<div class=\'dz-default dz-clickable\' style=\'margin: 2em 0; text-align: center;\'><span>Drop files here to upload</span></div>'
      $('.dz-default dz-message').show()

      

      
       

      
      
$(document).ready(initialise_edit_tools)
$(document).on('page:load', initialise_edit_tools)
