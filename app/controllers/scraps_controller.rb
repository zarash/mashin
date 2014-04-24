class ScrapsController < ApplicationController
  def show

  end

  def scrap
    girbox_arr = ["دنده ای", "اتوماتیک"]
    fuel_arr = ["بنزین", "دوگانه سوز", "هایبرید", "دیزل"]
    
    colors = [ "آبي",    "قرمز",   "سبز",    "نارنجي",   "سفيد",   "مشکي",   "آلبالوئی",   "اخرائی",   "اطلسی",    "بادمجانی",   "بژ",   "بنفش",   "پوست پیازی",   "خاکستری",    "خاکی",   "زرد",    "زرشکی",    "سربی",   "سرمه ای",    "صورتی",    "طلائی",    "عدسی",   "عنابی",    "قهوه ای",    "کرم",    "مسی",    "نقرآبی",   "نقره ای",    "نوک مدادی",    "یشمی",   "مارون",    "طوسی",   "زیتونی",   "شتری",   "برنز",   "دلفینی",   "گیلاسی",   "یاسی"]

    scrap = Scrap.new
    scrap.url = "http://www.bama.ir/car/page="
    scrap.sweep

    scrap.save
    redirect_to action: "index"
  end

end
