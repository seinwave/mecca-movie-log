# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'StaticPages', type: :request do
  describe 'static route tests' do
    it 'should get root' do
      get root_path
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
    end

    it 'should get stats' do
      get stats_path
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:stats)
    end
  end
end
