require 'rails_helper'

RSpec.describe "Api::Users", type: :request do
  describe 'POST /users' do
    let(:user_params) { { user:  { name: 'higakijin', email: 'hm385.chejptks@gmail.com', password: '123456', password_confirmation: '123456'}}}
    it 'ユーザーが作成できること' do
      post api_users_path, params: user_params
      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)
      expect(json['user']).to include({
        'id' => be_present,
        'name' => 'higakijin',
        'email' => 'hm385.chejptks@gmail.com'
      })
    end

    let(:invalid_user_params) { { user: { name: 'higakijin', email: 'hm385.chejptks@gmail.com', password: '123456', password_confirmation: '1234' } } }
    it 'ユーザーの作成に失敗すること' do
      post api_users_path, params: invalid_user_params
      expect(response).to have_http_status(422)
      json = JSON.parse(response.body)
      expect(json['error']).to be_present
    end
  end
end
