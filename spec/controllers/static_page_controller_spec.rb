require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  describe 'static_pages#home action' do
    it 'should successfuly show the page' do
      get :home
      expect(response).to have_http_status(:success)
    end
  end
end
