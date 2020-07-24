class Dish <ApplicationRecord
  validates_presence_of :name, :description
  belongs_to :chef
  has_many :dish_ingredients
  has_many :ingredients, through: :dish_ingredients

  def total_calorie_count
    if ingredients.empty?
      0
    else
      ingredients.sum(:calories)
    end
  end
end
