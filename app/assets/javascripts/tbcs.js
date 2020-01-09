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
  });

  $('body input.tbcs-check-box').on('change', function() {
    $('input.tbcs-check-box').not(this).prop('checked', false);
    $(".tbc-booklrt-tables").hide();
    let tbcId = $(this).attr("id");
    $("#place-booklet-fl-btn").data("current-selected-tbc-table",tbcId);
    $("#"+tbcId+"-booklet-table").show();
  });

  $('body  input.tbcs-file-check-box').on('change', function() {
    var $this = $(this);
    if ($this.is(":checked")) {
        $this.closest("tr").addClass("highlight");
    } else {
        $this.closest("tr").removeClass("highlight");
    }
  });

  $("body #place-booklet-fl-btn").on("click",function(){
    let tableHighlightedRows = $("table.tbc-selected-files-tb tr.highlight")
    let currentSelectedTbcTableId = $("#place-booklet-fl-btn").data("current-selected-tbc-table");
    var i;
    for (i = 0; i < tableHighlightedRows.length; i++) {
      $("#"+currentSelectedTbcTableId+"-booklet-table").append(tableHighlightedRows[i]);
    }
  })
});
