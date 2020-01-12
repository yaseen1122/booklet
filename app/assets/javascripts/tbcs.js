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

  $(document).on("change", "input.tbcs-check-box", function(e) {
    $('input.tbcs-check-box').not(this).prop('checked', false);
    $(".tbc-booklet-tables").hide();
    let tbcId = $(this).attr("id");
    $("#place-booklet-fl-btn").data("current-selected-tbc-table",tbcId);
    $("#"+tbcId+"-booklet-table").show();
  });



  $(document).on("change", "input.tbcs-file-check-box", function(e) {
    var $this = $(this);
    if ($this.hasClass("booklet-selected") && $this.closest("table").hasClass("tbc-booklet-tables")){

      if (confirm('Are you sure you want to unselect this file from booklet.?')) {
          $this.closest("tr").removeClass("highlight");
          $(".tbc-selected-files-tb").append($this.closest("tr"));
      } else {
        $this.prop('checked', true);
      }

     
    }
    else {
      if ($this.is(":checked")) {
          $this.addClass("booklet-selected");
          $this.closest("tr").addClass("highlight");
      } else {
          $this.removeClass("booklet-selected")
          $this.closest("tr").removeClass("highlight");
      }
    }
  });


  $(document).on("click", "#place-booklet-fl-btn", function(e) {
    let $tableHighlightedRows = $("table.tbc-selected-files-tb tr.highlight")
    let currentSelectedTbcTableId = $("#place-booklet-fl-btn").data("current-selected-tbc-table");
    let checkAnytbcSelected       = $(".tbcs-check-box:checkbox:checked").length > 0 ? true : false 
    let checkAnyFileSelectedForTbc      = $(".tbc-selected-files-tb .tbcs-file-check-box:checkbox:checked").length > 0 ? true : false
    // $tableHighlightedRows.each(function( index ) {
    //   $("#"+currentSelectedTbcTableId+"-booklet-table").append($(this).find("td:gt(0)"));
    // });

    if (checkAnytbcSelected && checkAnyFileSelectedForTbc){
      var i;
      for (i = 0; i < $tableHighlightedRows.length; i++) {
        $("#"+currentSelectedTbcTableId+"-booklet-table").append($tableHighlightedRows[i]);
      }
    }
    else{
      alert("Please select any Table of Content and list of file(s) before this action.")
    }
  });


  $(document).on("click", "#generate-booklet", function(e) {
    // let checkIfAnyTbcFileSelected = ($(".tbc_selected_files_tables > table tbody tr").length > 0) ? true : false 

    // if (checkIfAnyTbcFileSelected) {
    //   var bookletletHash = {};
    //   $(".tbc-booklet-tables").each(function(index) {
    //     let currentTable = $(this);
    //     let abc = []
    //     currentTable.find('tr').each(function (i, el) {
    //       var $tds = $(this).data('booklet-file-path');
    //       abc.push($tds);
    //     });
    //     bookletletHash[currentTable.data("tbc-id")] = abc
    //   });
    //   $.ajax({
    //     type: "GET",
    //     url: "/generate_booklet.js",
    //     data:{booklet_hash: bookletletHash},
    //     dataType: "script"
    //   });
    // }
    // else{
    //   alert("Please select some files first for any Table of Content to generate the Booklet.")
    // }
    if (confirm('Comming Soon!')) {}
  });

});
