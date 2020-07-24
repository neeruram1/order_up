require 'rails_helper'

RSpec.describe Chef, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
  end

  describe "relationships" do
    it {should have_many :dishes}
  end

  describe 'methods' do
    it "#ingredient_list" do
      tony = Chef.create(name: "Anthony Bourdain")

      sunday_gravy = Dish.create(name: "Sunday Gravy with Sausage and Rigatoni", description: "An Italo-American Jersey classic", chef: tony)
      boeuf = Dish.create(name: "Boeuf Bourguignon", description: "A classic French dish that sticks to your ribs", chef: tony)

      sausage = Ingredient.create(name: "Hot Pork Sausage Links", calories: 240.0)
      rigatoni = Ingredient.create(name: "Rigatoni", calories: 340.0)
      parm = Ingredient.create(name: "Parmigiano-Reggiano", calories: 400)

      garlic = Ingredient.create(name: "Garlic Clove", calories: 50.0)
      carrots = Ingredient.create(name: "Carrots", calories: 140.0)
      beef = Ingredient.create(name: "Beef Shoulder", calories: 450.0)

      DishIngredient.create(dish: sunday_gravy, ingredient: sausage)
      DishIngredient.create(dish: sunday_gravy, ingredient: rigatoni)
      DishIngredient.create(dish: sunday_gravy, ingredient: parm)
      DishIngredient.create(dish: sunday_gravy, ingredient: garlic)

      DishIngredient.create(dish: boeuf, ingredient: garlic)
      DishIngredient.create(dish: boeuf, ingredient: carrots)
      DishIngredient.create(dish: boeuf, ingredient: beef)

      expect(tony.ingredient_list).to eq([beef.name, carrots.name, garlic.name, sausage.name, parm.name, rigatoni.name])
    end
  end
end
