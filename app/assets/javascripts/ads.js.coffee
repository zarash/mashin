$ ->
  $("#ad_show #thumbs .thumb").hover ->
    $(this).parent().children().removeClass("my_active")
    $(this).addClass("my_active")
    $("#big_images .big_image").hide()
    index = $("#ad_show #thumbs .thumb").index(this)
    $("#big_images .big_image:nth-child("+(index+1)+")").show()
