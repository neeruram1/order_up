class Chef <ApplicationRecord
  validates_presence_of :name
  has_many :dishes

  def ingredient_list
    dishes.select("ingredients.name").joins(:ingredients).distinct("ingredients.name").pluck("ingredients.name")
  end
end
