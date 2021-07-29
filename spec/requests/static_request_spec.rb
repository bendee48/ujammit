require 'rails_helper'

RSpec.describe "Statics", type: :request do
  let(:user) { create(:user) }

  describe 'GET /' do
    it 'successfully loads homepage' do
      login_as(user, scope: :user)
      get root_path
      expect(response).to render_template(:homepage)
      expect(response).to have_http_status(200)
    end
  end
end
