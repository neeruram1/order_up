require 'rails_helper'

RSpec.desribe Ingredient, type: :model do
  describe "relationships" do
    it {should have_many :dish_ingredients}
  end
end
