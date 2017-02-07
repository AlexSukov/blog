$ ->
  $(document).ready ->
    Dropzone.autoDiscover = false
    myDropzone = new Dropzone('#myForm',
      autoProcessQueue: false
      addRemoveLinks: true
      maxFilesize: 5
      maxFiles: 10
      parallelUploads: 10
      uploadMultiple: true
      paramName: 'attachments[file_name]'
  )
    $('#myForm').submit (e) ->
      if myDropzone.getQueuedFiles().length > 0
        e.preventDefault()
        e.stopPropagation()
        myDropzone.processQueue()
      return
  $(document).on 'click', '.delete_att', ->
    $parent = $(this).parent()
    post_id = $('#post_id').val()
    att_id = $parent.find('.att_id').val()
    $.ajax
      type: 'DELETE'
      url: "/posts/#{post_id}/attachments/#{att_id}"
      dataType: "json"
      success: (data) ->
        $parent.remove()
      error: (data) ->
        alert('Произошла непредвиденная ошибка.')
