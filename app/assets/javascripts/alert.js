function closeAlert(duration) {
  setTimeout(() => {
    $("#myModal").css("display", "none");
  }, duration);
}
$(window).on("load", function () {
  closeAlert(2000);
  $("#myModal").css("display", "block");
});
