require 'rails_helper'

RSpec.describe 'Authentication', type: :feature do
  let(:user) { create(:user, :unauthorised) } # User initially isn't authorised

  describe 'authorizing Spotify' do
    context 'user has not authorized Spotify' do
      it 'returns no access token for current user' do
        login_as(user, scope: :user)

        visit root_path

        expect(page).to have_current_path(root_path)
        expect(user.access_token).to eql nil
      end

      it 'shows button for authorization' do
        login_as(user, scope: :user)
        
        visit root_path

        expect(page).to have_current_path(root_path)
        expect(page).to have_selector('#authorize-btn')
      end
    end

    context 'user has authorized Spotify' do
      # Mechanize allows Capybara to use remote requests
      it 'does not show authorize button and saves refresh token', driver: :mechanize do
        login_as(user, scope: :user)
        visit root_path

        # stub authorize
        allow(SpotifyApi).to receive(:state_code).and_return('xyxyx')
        stub_const("#{SpotifyApi}::CLIENT_ID", '12345')
        state = 'xyxyx'
        authorize(client_id: SpotifyApi::CLIENT_ID,
                  state: state,
                  return_info: {headers: {location: callback_path}, body: [1,2,3]})
          
        # stub callback
        credentials = 'xyxyxyx'
        auth_code = nil
        allow(SpotifyApi).to receive(:encoded_credentials).and_return(credentials)

        request_token(auth_code: auth_code,
                      return_info: {body: {access_token: '1234', refresh_token: '5678', expires_in: 15}.to_json})
        
        click_on('Authorize Spotify')
        user.reload # Reload user to show changes from db after authorisation

        expect(page).to have_current_path(root_path)
        expect(page).to_not have_selector('#authorize-btn')
        expect(user.refresh_token).to eql '5678'
      end
    end
  end
end