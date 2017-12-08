# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('#wysiwyg').froalaEditor
    language: 'ru'
    imageOutputSize: true
    imageUploadURL: 'https://liveanimations.org/upload_image'
    fileUploadURL: 'https://liveanimations.org/upload_image'
    videoUploadURL: 'https://liveanimations.org/upload_image'
