let modal = document.getElementById("myModal");
function closeAlert(duration) {
  setTimeout(function () {
    modal.parentNode.removeChild(modal);
  }, duration);
}

window.onload = function () {
  closeAlert(2000);
  modal.style.display = "block";
};
