require 'rails_helper'

RSpec.describe "Chef show page" do
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
    DishIngredient.create(dish: @sunday_gravy, ingredient: @garlic)

    DishIngredient.create(dish: @boeuf, ingredient: @garlic)
    DishIngredient.create(dish: @boeuf, ingredient: @carrots)
    DishIngredient.create(dish: @boeuf, ingredient: @beef)
  end
  it "I see the name of the chef and a link to view a list of all ingredients this chef uses in dishes" do

    visit "/chefs/#{@tony.id}"

    expect(page).to have_content(@tony.name)

    click_on "Ingredients"

    expect(current_path).to eq("/chef/#{@tony.id}/ingredients")

    expect(page).to have_content(@sausage.name)
    expect(page).to have_content(@rigatoni.name)
    expect(page).to have_content(@parm.name)
    expect(page).to have_content(@garlic.name)
    expect(page).to have_content(@carrots.name)
    expect(page).to have_content(@beef.name)
  end

  it "I see the three most popular ingredients that the chef uses in their dishes" do
    DishIngredient.create(dish: @sunday_gravy, ingredient: @carrots)
    DishIngredient.create(dish: @boeuf, ingredient: @parm)

    visit "/chefs/#{@tony.id}"

    within ".popular-ingredients" do
      expect(page).to have_content("Three Most Popular Ingredients:")
      expect(page).to have_content(@garlic.name)
      expect(page).to have_content(@parm.name)
      expect(page).to have_content(@carrots.name)

      expect(page).to_not have_content(@beef.name)
    end
  end
end
