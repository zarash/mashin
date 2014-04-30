jQuery ->
  car_models = $('#car_model_id').html()

  make = $("option:selected", "#make_id").text()
  
  escaped_car_models = make.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
  options = $(car_models).filter("optgroup[label='#{escaped_car_models}']").html()
  options = ["<option value=\"\"></option>"]+options 
  $('#car_model_id').html(options)

  $('#make_id').change ->
    $('#car_model_id').html('')
    make = $("option:selected", this).text()
    escaped_car_models = make.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
    options = $(car_models).filter("optgroup[label='#{escaped_car_models}']").html()
    options = ["<option value=\"\"></option>"]+options 
    $('#car_model_id').html(options)