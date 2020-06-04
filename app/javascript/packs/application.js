require("@rails/ujs").start();
require("turbolinks").start();
require("@rails/activestorage").start();
require("channels");
require("popper.js");



//bootstrap 

import "bootstrap"
import "bootstrap/dist/css/bootstrap.min.css"

//JQ
import "jquery"
import $ from 'jquery'
window.$ = $
require("scripts");

//fontawesome

import "@fortawesome/fontawesome-free/css/all.css";

import "controllers"

//clipboard
import "clipboard"
import ClipboardJS from "clipboard/dist/clipboard.min.js"



$(document).on("turbolinks:load", function(){
  // https://github.com/zenorocha/clipboard.js  copy用插件
  new ClipboardJS('.btn');
  $('.collapse').collapse('hide')
})

require("style");
