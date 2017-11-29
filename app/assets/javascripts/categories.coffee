# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  header_height = $('header').height()
  main_height = $('main').height()
  footer_height = $('footer').height()
  max_height = header_height + main_height + footer_height
  if(max_height < $(window).height())
    $('footer').addClass('mobile-fixed')
