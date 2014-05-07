class CreateColors < ActiveRecord::Migration
  def up
    create_table :colors do |t|
      t.string :name
      t.boolean :visible, default: true
    end

    add_index :colors, :name

    Color.create([
      {   name: "قرمز"   },
      {   name: "سبز"   },
      {   name: "نارنجي"   },
      {   name: "سفيد"   },
      {   name: "مشکي"   },
      {   name: "آلبالوئی"   },
      {   name: "اخرائی"   },
      {   name: "اطلسی"   },
      {   name: "بادمجانی"   },
      {   name: "بژ"   },
      {   name: "بنفش"   },
      {   name: "پوست پیازی"   },
      {   name: "خاکستری"   },
      {   name: "خاکی"   },
      {   name: "زرد"   },
      {   name: "زرشکی"   },
      {   name: "سربی"   },
      {   name: "سرمه ای"   },
      {   name: "صورتی"   },
      {   name: "طلائی"   },
      {   name: "عدسی"   },
      {   name: "عنابی"   },
      {   name: "قهوه ای"   },
      {   name: "کرم"   },
      {   name: "مسی"   },
      {   name: "نقرآبی"   },
      {   name: "نقره ای"   },
      {   name: "نوک مدادی"   },
      {   name: "یشمی"   },
      {   name: "مارون"   },
      {   name: "طوسی"   },
      {   name: "زیتونی"   },
      {   name: "شتری"   },
      {   name: "برنز"   },
      {   name: "دلفینی"   },
      {   name: "گیلاسی"   },
      {   name: "یاسی"   },
      {   name: "آبي"   }
    ])

  end

  def down
    drop_table :colors
  end
end
