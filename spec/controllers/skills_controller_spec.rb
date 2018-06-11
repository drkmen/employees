# frozen_string_literal: true

# Skill ControllerSpec
require 'rails_helper'

RSpec.describe SkillsController, type: :controller do

  before do
    FactoryBot.create(:employee, :admin_full)
    FactoryBot.create(:skill)
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      get :edit, params: { id: Skill.last.id }
      expect(response.status).to eq(200)
      expect(response).to render_template('edit')
      expect(assigns(:skill)).to eq(Skill.last)
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new
      expect(response.status).to eq(200)
      expect(response).to render_template('new')
      expect(assigns(:skill).name).to eq(nil)
    end
  end

  describe 'PUT #update' do
    it 'returns a success response' do
      put :update,
        params: {
          id: Skill.last.id,
          skill: {
            name: 'qweqwe'
          }
        }
      expect(response.status).to eq(302)
      expect(redirect_to(root_path)).to be_truthy
      expect(Skill.last.name).to eq('qweqwe')
    end
  end

  describe 'POST #create' do
    it 'returns a success response' do
      expect do
        post :create,
          params: {
            skill: {
              name: 'qweqwe'
            }
          }
      end.to(change { Skill.count }.by(1)) &&
        redirect_to(root_path &&
        have_http_status(302))
    end

    it 'returns a fail response and render #new' do
      name = 'qweqwe'
      Skill.create(name: name)
      expect do
        post :create,
          params: {
            skill: {
              name: name
            }
          }
      end.to(change { Skill.count }.by(0)) &&
        have_http_status(200) &&
        render_template('new')
    end
  end

  describe 'Delete #destroy' do
    it 'returns a success response' do
      expect do
        post :destroy, params: { id: Skill.last.id }
      end.to(change { Skill.count }.by(-1)) &&
          have_http_status(302) &&
          render_template('index')
    end
  end

end
