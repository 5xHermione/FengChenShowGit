$().ready(function(){
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
  });
});