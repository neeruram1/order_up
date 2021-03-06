require 'rails_helper'

RSpec.describe "Dish show page" do
  before(:each) do
    @tony = Chef.create(name: "Anthony Bourdain")

    @sunday_gravy = Dish.create(name: "Sunday Gravy with Sausage and Rigatoni", description: "An Italo-American Jersey classic", chef: @tony)
    @boeuf = Dish.create(name: "Boeuf Bourguignon", description: "A classic French dish that sticks to your ribs", chef: @tony)

    @sausage = Ingredient.create(name: "Hot Pork Sausage Links", calories: 240.0)
    @rigatoni = Ingredient.create(name: "Rigatoni", calories: 340.0)
    @parm = Ingredient.create(name: "Parmigiano-Reggiano", calories: 400)

    @garlic = Ingredient.create(name: "Garlic Clove", calories: 50.0)
    @carrots = Ingredient.create(name: "Carrots", calories: 140.0)
    @beef = Ingredient.create(name: "Beef Shoulder", calories: 450.0)

    DishIngredient.create(dish: @sunday_gravy, ingredient: @sausage)
    DishIngredient.create(dish: @sunday_gravy, ingredient: @rigatoni)
    DishIngredient.create(dish: @sunday_gravy, ingredient: @parm)

    DishIngredient.create(dish: @boeuf, ingredient: @garlic)
    DishIngredient.create(dish: @boeuf, ingredient: @carrots)
    DishIngredient.create(dish: @boeuf, ingredient: @beef)
  end

  it "I see a list of ingredients for that dish and the chef's name" do

    visit "/dishes/#{@sunday_gravy.id}"

    expect(page).to have_content(@tony.name)
    expect(page).to have_content(@sausage.name)
    expect(page).to have_content(@rigatoni.name)
    expect(page).to have_content(@parm.name)
  end

  it "I see the total calorie count for that dish" do
    visit "/dishes/#{@sunday_gravy.id}"

    expect(page).to have_content("Total Calorie Count: 980")
  end
end
