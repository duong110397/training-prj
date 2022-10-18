let modal = document.getElementById("myModal");
function closeAlert(duration) {
  setTimeout(() => {
    modal.parentNode.removeChild(modal);
  }, duration);
}
window.onload = () => {
  closeAlert(2000);
  modal.style.display = "block";
};
