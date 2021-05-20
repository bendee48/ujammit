require 'rails_helper'

RSpec.describe 'Authentication', type: :feature do
  let(:user) { build_stubbed(:user) }

  describe 'user authorizes spotify' do
    context 'user has not yet authorized spotify' do
      it 'no access token is saved' do
        login_as(user, scope: :user)

        visit root_path
        
        expect(page).to have_current_path(root_path)
        expect(Rails.cache.exist?(:access_token)).to eql false
      end
      # will have to stub response and keys so testing whther button is there?
    end
  end
end