# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
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
