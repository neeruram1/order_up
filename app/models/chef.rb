class Chef <ApplicationRecord
  validates_presence_of :name
  has_many :dishes

  def ingredient_list
    dishes.select("ingredients.name").joins(:ingredients).distinct("ingredients.name").pluck("ingredients.name")
  end

  def popular_ingredients
    dishes.joins(:ingredients).select("ingredients.name, count(ingredients.name) as count").group("ingredients.name").order("count DESC").limit(3)
  end
end
