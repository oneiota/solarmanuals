jQuery ->
  $("a[rel=popover]").popover()
  $(".tooltip").tooltip()
  $("a[rel=tooltip]").tooltip()
  
  $("input[data-loading-text]").on "click", (e) ->
    width = $(this).width()
    $(this).val($(this).data("loading-text"))
    $(this).css("width", width)