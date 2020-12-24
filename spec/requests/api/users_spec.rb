require 'swagger_helper'

RSpec.describe 'api/users', type: :request do
  path '/api/users/{id}' do
    patch 'Update User' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :authenticity_token, in: :header, type: :string
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          first_name: { type: :string },
          last_name: { type: :string },
          image: { type: :string }
        },
        required: ['id']
      }

      response '201', 'Success' do
        user = User.first
        let(:authenticity_token) { user.authenticity_token }
        let(:id) { user.id }
        let(:user) { { first_name: 'Kirill', last_name: 'Stolpnik', image: user.image.url } }
        run_test!
      end

      response '409', 'Попытка изменить другого пользователя' do
        user = User.first
        let(:authenticity_token) { User.last.authenticity_token }
        let(:id) { user.id }
        let(:user) { { first_name: 'Kirill', last_name: 'Stolpnik', image: user.image.url } }
        run_test!
      end
    end
  end
end
