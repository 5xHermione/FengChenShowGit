$(document).on("turbolinks:load", function () {
  let editButton = $(".comment-edit-button");
  let cancelButton = $(".comment-cancel-button");

  editButton.click(function () {
    $(".comment-info-container").hide();
    $(".comment-edit-container").show();
  });

  cancelButton.click(function () {
    $(".comment-edit-container").hide();
    $(".comment-info-container").show();
  });
});