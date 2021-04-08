# frozen_string_literal: true

require 'rails_helper'
require_relative './support/devise'
require 'capybara/rspec'

RSpec.describe DeviseController, type: :controller do
  describe 'GET /' do
    include Capybara::DSL
    login_user

    context 'when login user' do
      it 'user can log in' do
        expect(get: '/').to route_to(controller: 'home', action: 'index')
        expect(response.status).to eq(200)
      end
    end
  end
end
