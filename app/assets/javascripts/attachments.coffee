# Place all the behaviors and hooks related to the matching controller here.
#All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  # disable auto discover
  Dropzone.autoDiscover = false
  # grap our upload form by its id
  $('#new_attachment').dropzone
    autoProcessQueue: false
    maxFilesize: 1
    paramName: 'attachment[file_name]'
    addRemoveLinks: true
    success: (file, response) ->
      # find the remove button link of the uploaded file and give it an id
      # based of the fileID response from the server
      $(file.previewTemplate).find('.dz-remove').attr 'id', response.id
      # add the dz-success class (the green tick sign)
      $(file.previewElement).addClass 'dz-success'
      return
    removedfile: (file) ->
      # grap the id of the uploaded file we set earlier
      id = $(file.previewTemplate).find('.dz-remove').attr('id')
      # make a DELETE ajax request to delete the file
      $(document).find(file.previewElement).remove();
      $.ajax
        type: 'DELETE'
        url: '/attachments/' + id
        success: (data) ->
          console.log data.message
          return
      return
  return
