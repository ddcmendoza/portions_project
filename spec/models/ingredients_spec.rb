require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  describe 'validations' do
    it { expect(described_class.new).to validate_presence_of :name }

    context 'when the name is taken on the same brand' do
      it 'does not save the duplicate' do
        ingredient1 = FactoryBot.build(:ingredient)
        ingredient2 = FactoryBot.build(:ingredient)
        ingredient1.save
        expect(ingredient2.save).to be_falsy
      end

      it 'saves when not on the same brand' do
        ingredient1 = FactoryBot.build(:ingredient)
        ingredient2 = FactoryBot.build(:ingredient, :brand2)
        ingredient1.save
        expect(ingredient2.save).to be_truthy
      end
    end
  end
end
