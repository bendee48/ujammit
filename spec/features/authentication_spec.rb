require 'rails_helper'

RSpec.describe 'Authentication', type: :feature do
  let(:user) { build_stubbed(:user) }

  describe 'authorising Spotify' do
    context 'user has not yet authorised Spotify' do
      xit 'does something' do
        login_as(user, scope: :user)

        visit root_path
        
        expect(page).to have_current_path(root_path)
        expect(Rails.cache.exist?(:access_token)).to eql false
      end

      it 'shows button for authorisation' do
        login_as(user, scope: :user)

        visit root_path

        expect(page).to have_selector('#authorise-btn')
      end
    end

    context 'user has authorised Spotify' do
      it 'does not show authorise button' do
        # will have to stub response and keys so testing whther button is there?        
      end
    end
  end
end