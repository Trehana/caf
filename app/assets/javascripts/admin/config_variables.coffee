window.CKEDITOR_config = {}
window.CKEDITOR_config.with_images =
  toolbar:  [
              {
                name: 'clipboard'
                groups: [
                  'clipboard'
                  'undo'
                ]
                items: [
                  'Cut'
                  'Copy'
                  'Paste'
                  'PasteText'
                  'PasteFromWord'
                  '-'
                  'Undo'
                  'Redo'
                ]
              }
              {
                name: 'editing'
                groups: [
                  'find'
                  'selection'
                  'spellchecker'
                ]
                items: [
                  'Find'
                  'Replace'
                  '-'
                  'SelectAll'
                  '-'
                  'Scayt'
                ]
              }
              {
                name: 'basicstyles'
                groups: [
                  'basicstyles'
                  'cleanup'
                ]
                items: [
                  'Bold'
                  'Italic'
                  'Underline'
                  'Strike'
                  'Subscript'
                  'Superscript'
                  '-'
                  'RemoveFormat'
                ]
              }
              {
                name: 'paragraph'
                groups: [
                  'list'
                  'indent'
                  'blocks'
                  'align'
                  'bidi'
                ]
                items: [
                  'NumberedList'
                  'BulletedList'
                  '-'
                  'Outdent'
                  'Indent'
                  '-'
                  'Blockquote'
                  'CreateDiv'
                  '-'
                  'JustifyLeft'
                  'JustifyCenter'
                  'JustifyRight'
                  'JustifyBlock'
                ]
              }
              {
                name: 'links'
                items: [
                  'Link'
                  'Unlink'
                  'Anchor'
                ]
              }
              {
                name: 'insert'
                items: [
                  'Image'
                  'Table'
                  'HorizontalRule'
                  'Smiley'
                  'SpecialChar'
                  'PageBreak'
                  'Iframe'
                ]
              }
              {
                name: 'styles'
                items: [
                  'Styles'
                  'Format'
                  'Font'
                  'FontSize'
                ]
              }
              {
                name: 'colors'
                items: [
                  'TextColor'
                  'BGColor'
                ]
              }
              {
                name: 'tools'
                items: [
                  'Maximize'
                  'ShowBlocks',
                  'Source'
                ]
              }
              {
                name: 'others'
                items: [ '-' ]
              }
            ]

window.CKEDITOR_config.without_images =
  toolbar:  [
              {
                name: 'clipboard'
                groups: [
                  'clipboard'
                  'undo'
                ]
                items: [
                  'Cut'
                  'Copy'
                  'Paste'
                  'PasteText'
                  'PasteFromWord'
                  '-'
                  'Undo'
                  'Redo'
                ]
              }
              {
                name: 'editing'
                groups: [
                  'find'
                  'selection'
                  'spellchecker'
                ]
                items: [
                  'Find'
                  'Replace'
                  '-'
                  'SelectAll'
                  '-'
                  'Scayt'
                ]
              }
              {
                name: 'basicstyles'
                groups: [
                  'basicstyles'
                  'cleanup'
                ]
                items: [
                  'Bold'
                  'Italic'
                  'Underline'
                  'Strike'
                  'Subscript'
                  'Superscript'
                  '-'
                  'RemoveFormat'
                ]
              }
              {
                name: 'paragraph'
                groups: [
                  'list'
                  'indent'
                  'blocks'
                  'align'
                  'bidi'
                ]
                items: [
                  'NumberedList'
                  'BulletedList'
                  '-'
                  'Outdent'
                  'Indent'
                  '-'
                  'Blockquote'
                  'CreateDiv'
                  '-'
                  'JustifyLeft'
                  'JustifyCenter'
                  'JustifyRight'
                  'JustifyBlock'
                ]
              }
              {
                name: 'styles'
                items: [
                  'Styles'
                  'Format'
                  'Font'
                  'FontSize'
                ]
              }
              {
                name: 'colors'
                items: [
                  'TextColor'
                  'BGColor'
                ]
              }
              {
                name: 'tools'
                items: [
                  'Maximize'
                  'ShowBlocks',
                  'Source'
                ]
              }
              {
                name: 'others'
                items: [ '-' ]
              }
            ]
