$ ->
  $("#js-transaction-participants-toggle").click (event) ->
    event.preventDefault()
    target = $(event.target)
    if target.data("all") == target.text()
      $("#js-transaction-participants input[type='checkbox']").prop("checked", true)
      target.text(target.data("none"))
    else
      $("#js-transaction-participants input[type='checkbox']").prop("checked", false)
      target.text(target.data("all"))
