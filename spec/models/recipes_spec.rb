require 'rails_helper'

RSpec.describe Recipe, type: :model do
  describe 'validations' do
    it { expect(described_class.new).to validate_presence_of :name }

    context 'when the name is taken on the same category' do
      let(:user) { FactoryBot.create(:user) }
      let(:category) { user.recipe_categories[0] }

      it 'does not save the duplicate' do
        recipe1 = FactoryBot.build(:recipe)
        recipe2 = FactoryBot.build(:recipe)
        recipe1.recipe_category = category
        recipe2.recipe_category = category
        recipe1.save
        expect(recipe2.save).to be_falsy
      end
    end
  end
end
