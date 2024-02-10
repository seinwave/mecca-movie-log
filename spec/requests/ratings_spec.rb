# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Ratings', type: :request do
  context 'GET /ratings' do
    it 'should respond with a 200 (OK)' do
      get '/ratings'
      expect(response).to have_http_status(200)
    end

    it 'should render the index template' do
      get '/ratings'
      expect(response).to render_template(:index)
    end

    it 'should render a list of ratings' do
      get '/ratings'
      expect(response.body).to include('Ratings')
    end
  end
end
