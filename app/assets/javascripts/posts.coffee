# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  if window.gon
    $('#wysiwyg').froalaEditor
      language: 'ru'
      imageOutputSize: true
      imageUploadToS3: gon.aws_data
      fileUploadToS3: gon.aws_data
      videoUploadToS3: gon.aws_data
  header_height = $('header').height()
  main_height = $('main').height()
  footer_height = $('footer').height()
  max_height = header_height + main_height + footer_height
  if(max_height < $(window).height())
    $('footer').addClass('mobile-fixed')
