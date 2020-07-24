require 'rails_helper'

RSpec.describe Dish, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
  end

  describe "relationships" do
    it {should belong_to :chef}
    it {should have_many :dish_ingredients}
    it {should have_many(:ingredients).through(:dish_ingredients)}
  end

  describe "methods" do
    it "#total_calorie_count" do
      tony = Chef.create(name: "Anthony Bourdain")

      sunday_gravy = Dish.create(name: "Sunday Gravy with Sausage and Rigatoni", description: "An Italo-American Jersey classic", chef: tony)

      sausage = Ingredient.create(name: "Hot Pork Sausage Links", calories: 240.0)
      rigatoni = Ingredient.create(name: "Rigatoni", calories: 340.0)
      parm = Ingredient.create(name: "Parmigiano-Reggiano", calories: 400)

      DishIngredient.create(dish: sunday_gravy, ingredient: sausage)
      DishIngredient.create(dish: sunday_gravy, ingredient: rigatoni)
      DishIngredient.create(dish: sunday_gravy, ingredient: parm)

      expect(sunday_gravy.total_calorie_count).to eq(980.0)
    end
  end
end
