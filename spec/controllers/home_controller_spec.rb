# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe 'GET index' do
    it 'renders the index template' do
      get :index
      pp :index
      expect(response.status).to eq(200)
    end
  end
end
