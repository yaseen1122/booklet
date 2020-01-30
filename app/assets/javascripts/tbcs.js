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

        let selectedFilePath = $this.closest("tr").data("booklet-file-path")  
        let bookletId  = $(".main-edit-booklet-area").data("booklet_id")
        let currentSelectedTbcTableId = $("#place-booklet-fl-btn").data("current-selected-tbc-table");

        $this.closest("tr").removeClass("highlight");
        $(".tbc-selected-files-tb").append($this.closest("tr"));
        $('#loading').show();
        
        $.ajax({
          type: "GET",
          url: "/delete_selected_file.js",
          data:{current_selected_tbc_id: currentSelectedTbcTableId , delete_selected_file_path: selectedFilePath, booklet_id: bookletId  },
          dataType: "script",
          success: function (data) {
            $('#loading').hide();
          },
          failure: function (data) {
            $('#loading').hide();
          }
        });

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
    let checkIfAnyTbcFileSelected = ($(".tbc_selected_files_tables > table tbody tr").length > 0) ? true : false 

    if (checkIfAnyTbcFileSelected) {
      var bookletletHash = {};
      var bookletName  = $(".main-edit-booklet-area").data("booklet_name")

      $(".tbc-booklet-tables").each(function(index) {
        let currentTable = $(this);
        let abc = []
        currentTable.find('tr').each(function (i, el) {
          var $tds = $(this).data('booklet-file-path');
          abc.push($tds);
        });
        bookletletHash[currentTable.data("tbc-id")] = abc
      });
      $('#loading').show();
      $.ajax({
        type: "GET",
        url: "/generate_booklet.js",
        data:{booklet_hash: bookletletHash, booklet_name: bookletName },
        dataType: "script",
        success: function (data) {
          $('#loading').hide();
        },
        failure: function (data) {
          $('#loading').hide();
          
        }
      });
    }
    else{
      alert("Please select some files first for any Table of Content to generate the Booklet.")
    }
  });

  $(document).on("click", "#upload-booklet", function(e) {
    $("#booklet-upload-form-modal").modal("show")
  });

  $(document).on("click", "#upload_booklets_btn", function(e) {

    if($("#booklets-input").files.length == 0 ){
      return false
    }else{
      $("#booklet-upload-form-modal").modal("hide")
      $('#loading').show();
    }
  });

  $(document).on("click", "#delete-booklet", function(e) {
      let $tableHighlightedRows = $("table.tbc-selected-files-tb tr.highlight");
      let currentBookletId = $('.main-edit-booklet-area').data('booklet_id')
      var selected_deleted_files = []
      if ($tableHighlightedRows.length > 0 ){

        if (confirm('Are you sure you want to delete this selected files from booklet.?')) {
          for (i = 0; i < $tableHighlightedRows.length; i++) {
            selected_deleted_files.push($tableHighlightedRows[i].dataset["bookletFilePath"])
          }
          $('#loading').show();
          $.ajax({
            type: "GET",
            url: "/delete_booklets.js",
            data:{delete_selected_files: selected_deleted_files, id: currentBookletId},
            dataType: "script",
            success: function (data) {
              $('#loading').hide();
            },
            failure: function (data) {
              $('#loading').hide();
            }
          });
        };
      }else {
        alert("Please select the files first which you want to be deleted.")
      }
  });

});
