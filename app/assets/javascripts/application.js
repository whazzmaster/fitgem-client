// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(document).ready(function() {
  // alert UI icons
  $('.alert-box').each(function(){
    if($(this).children('span.alert_icon').length < 1){
      $('<span class="alert_icon"></span>').prependTo($(this));
    }
  });

  $('.multiline-alert-box').each(function(){
    if($(this).children('span.alert_icon').length < 1){
      $('<span class="alert_icon"></span>').prependTo($(this));
    }
  });

  $('.information-box').each(function(){
    if($(this).children('span.success_icon').length < 1){
      $('<span class="success_icon"></span>').prependTo($(this));
    }
  });

  $('.success-box').each(function(){
    if($(this).children('span.success_icon').length < 1){
      $('<span class="success_icon"></span>').prependTo($(this));
    }
  });

  $('.error-box').each(function(){
    if($(this).children('span.error_icon').length < 1){
      $('<span class="error_icon"></span>').prependTo($(this));
    }
  });
});