module ApplicationHelper
  def title(title)
    application_name = Rails.application.class.parent_name.underscore.titleize

    if title.empty?
      application_name
    else
      "#{application_name} | #{title}"
    end
  end
  
  # Toolbar configuration for CKEditor
  def editor_toolbar
    [
      { name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ], items: [ 'Bold', 'Italic', 'Underline', 'Strike', '-', 'Subscript', 'Superscript', '-', 'RemoveFormat' ] },
      { name: 'clipboard', groups: [ 'clipboard', 'undo' ], items: [ 'Cut', 'Copy', 'Paste', 'PasteText', 'PasteFromWord', '-', 'Undo', 'Redo' ] },
      { name: 'editing', groups: [ 'find', 'selection', 'spellchecker' ], items: [ 'Find', 'Replace', '-', 'SelectAll', '-', 'Scayt' ] },
      '/',
      { name: 'paragraph', groups: [ 'align', 'list', 'indent', 'blocks' ], items: [ 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock', '-', 'NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'Blockquote' ] },
      { name: 'insert', items: [ 'HorizontalRule', 'SpecialChar' ] },
      { name: 'styles', items: [ 'Format' ] },
      { name: 'others', items: [ '-' ] },
      { name: 'about', items: [ 'About' ] }
    ]
  end
end
