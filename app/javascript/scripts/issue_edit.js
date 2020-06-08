$(document).on("turbolinks:load", function(){

    $("#issue_edit").click(function(){
      $("#issue_update").show();
      $(".issue_name_active").show();
      $("#issue_edit").hide();
      $(".issue_name_inactive").hide();
      $(".issue_name_active input[type=text]").focus();
    });

    $("#issue_update").click(function(){
      $("#issue_edit").show();
      $(".issue_name_inactive").show();
      $("#issue_update").hide();
      $(".issue_name_active").hide();
      // debugger
    });

    $("#issue_description_edit").click(function(){
      $("#issue_description_update").show();
      $(".issue_description_active").show();
      $(".developer-comment-cancel-btn").show();
      $("#issue_description_edit").hide();
      $(".issue_description_inactive").hide();
      $(".issue_description_active textarea[type=text_area]").focus();
    });

    $("#issue_description_update").click(function(){
      $("#issue_description_edit").show();
      $(".issue_description_inactive").show();
      $("#issue_description_update").hide();
      $(".issue_description_active").hide();
      $(".developer-comment-cancel-btn").hide();
    });

});