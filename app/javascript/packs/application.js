require("@rails/ujs").start();
require("turbolinks").start();
require("@rails/activestorage").start();
require("channels");
require("style");
require("popper.js");


//bootstrap 

import "bootstrap"
import "bootstrap/dist/css/bootstrap.min.css"

//JQ
import "jquery"
import $ from 'jquery'
window.$ = $

//fontawesome

import "@fortawesome/fontawesome-free/css/all.css";

import "controllers"

//clipboard
import "clipboard"
import ClipboardJS from "clipboard/dist/clipboard.min.js"


$(document).on("turbolinks:load", function(){
  new ClipboardJS('.btn');
  $('.collapse').collapse()

})

$( document ).ready(function() {
 
});