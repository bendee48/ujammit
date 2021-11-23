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
    end
  end

  describe '#access_valid?' do
    context 'access token has not expired and is valid ' do
      it 'returns true' do
        expect(user.access_valid?).to eql true
      end
    end

    context 'access token has expired and is invalid' do
      it 'returns false' do
        user.access_token_expiration = DateTime.now - 60.seconds
        expect(user.access_valid?).to eql false
      end
    end
  end
end
