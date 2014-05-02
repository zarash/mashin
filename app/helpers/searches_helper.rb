module SearchesHelper

  def truncate_details ad
    txt =       COLORS[ad.body_color_id]+"، " if ad.body_color_id.present?
    txt = txt + GIRBOX_ARR[ (ad.girbox ? 1 : 0)]+"، " if ad.girbox?
    txt = txt + FUEL_ARR[ ad.fuel ]+"، " if ad.fuel > 0
    txt = txt + USAGE_ARR[ ad.usage_type ]+"، " if ad.usage_type > 0
    txt = txt + truncate(ad.details, length: 27, separator: ' ') unless ad.details == "-"
    txt
  end
end
