require 'rails_helper'

RSpec.describe 'Authentication', type: :feature do
  let(:user) { create(:user) }

  before(:each) do
    Rails.cache.clear
  end

  describe 'authorizing Spotify' do
    context 'user has not authorized Spotify' do
      xit 'does something' do
        login_as(user, scope: :user)

        visit root_path
        
        expect(page).to have_current_path(root_path)
        expect(Rails.cache.exist?(:access_token)).to eql false
      end

      it 'shows button for authorization' do
        login_as(user, scope: :user)

        visit root_path

        expect(page).to have_current_path(root_path)
        expect(page).to have_selector('#authorize-btn')
      end
    end

    context 'user has authorized Spotify' do
      it 'does not show authorize button', driver: :mechanize do
        login_as(user, scope: :user)
        visit root_path

        # stub authorize
        allow(SpotifyApi).to receive(:state).and_return('xyxyx')
        stub_const("#{SpotifyApi}::CLIENT_ID", '12345')
        state = 'xyxyx'

        authorize(client_id: SpotifyApi::CLIENT_ID,
                  state: state,
                  return_info: {headers: {location: callback_path}})

        # stub callback
        credentials = 'xyxyxyx'
        auth_code = nil
        allow(SpotifyApi).to receive(:encoded_credentials).and_return(credentials)

        request_token(auth_code: auth_code,
                      return_info: {body: {access_token: '1234', refresh_token: '5678', expires_in: 15}.to_json})
          
        click_on('Authorize Spotify')

        expect(page).to have_current_path(root_path)
        expect(page).to_not have_selector('#authorize-btn')
        expect(Rails.cache.fetch(:refresh_token)).to eql '5678'
      end
    end
  end
end