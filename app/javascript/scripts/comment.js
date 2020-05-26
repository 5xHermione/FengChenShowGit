$(document).on("turbolinks:load", function () {
  let editButton = $(".comment-edit-button");
  let cancelButton = $(".comment-cancel-button");

  editButton.click(function () {
    let $this = $(this)
    let $parent = $this.parents('.comment-info-container:eq(0)')
    let $editContainer = $parent.next(".comment-edit-container:eq(0)");
    $parent.hide();
    $editContainer.show();
  });

  cancelButton.click(function () {
    let $this = $(this)
    let $parent = $this.parents('.comment-edit-container')
    let $infoContainer = $parent.prev('.comment-info-container')
    $parent.hide();
    $infoContainer.show();
  });

});