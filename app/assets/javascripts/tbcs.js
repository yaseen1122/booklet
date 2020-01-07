$(document).ready(function(){
  // $("#mytable #checkall").click(function () {
  //   if ($("#mytable #checkall").is(':checked')) {
  //       $("#mytable input[type=checkbox]").each(function () {
  //           $(this).prop("checked", true);
  //       });

  //   } else {
  //       $("#mytable input[type=checkbox]").each(function () {
  //           $(this).prop("checked", false);
  //       });
  //   }
  // });

  $(" body #add-tbc-btn").on("click",function(){
    $("#new-tbc-form-modal").modal("show");
    $("#new-tbc-form")[0].reset();
  })
});