module MakesHelper

  def year_format_human make
    if make.year_format==true
      "shamsi"
    elsif make.year_format==false
      "miladi"
    end
  end
end
