$(function () {
  $(".datepicker").datepicker({
    dateFormat: "yy-mm-dd",
    showButtonPanel: true,
    changeMonth: true,
    changeYear: true,
    yearRange: "1999:2022",
    showOn: "button",
    buttonImage: "/assets/calendar.png",
    buttonImageOnly: true,
    minDate: new Date(1999, 10 - 1, 25),
    maxDate: "+30Y",
    inline: true,
  });
});
