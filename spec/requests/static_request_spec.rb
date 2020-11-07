require 'rails_helper'

RSpec.describe "Statics", type: :request do
  describe 'GET /' do
    it 'successfully loads homepage' do
      get root_path
      byebug
      expect(response).to render_template(:homepage)
      expect(response).to have_http_status(200)
    end
  end
end
