require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { build_stubbed(:user) }

  describe 'validations' do
    context 'is valid with valid attributes' do
      it { is_expected.to be_valid }
    end

    context 'is invalid' do
      it 'is invalid without an email' do
        user.email = nil
        expect(user).to be_invalid
      end

      it 'is invalid without a password' do
      end
    end
  end
end
