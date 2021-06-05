require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    # Email Validations

    it { expect(described_class.new).to validate_presence_of :email }

    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }

    it { is_expected.to allow_value('email@address.com').for(:email) }
    it { is_expected.to allow_value('email@address').for(:email) }
    it { is_expected.not_to allow_value('email@.com').for(:email) }
    it { is_expected.not_to allow_value('email@addrs.').for(:email) }

    context 'when the email is taken' do
      it 'does not save the duplicate' do
        user1 = FactoryBot.build(:user)
        user2 = FactoryBot.build(:user)
        user1.save
        expect(user2.save).to be_falsy
      end
    end
    # Password Validation

    it { expect(described_class.create).to validate_presence_of :encrypted_password }
  end

  describe 'callbacks' do
    it 'creates general category on create' do
      user3 = FactoryBot.create(:user)
      expect(user3.recipe_categories.length).to eq 1
    end
  end
end
