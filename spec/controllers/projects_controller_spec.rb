# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  before do
    @employee_developer = FactoryBot.create(:employee, :developer)
    FactoryBot.create(:project, employee_id: @employee_developer.id)
    sign_in @employee_developer
  end

  describe 'POST #create' do
    it 'returns a success response' do
      expect do
        post :create,
             params: {
               project: {
               repository: 'https://site.com',
               name: 'qweqwe',
               employee_id: Employee.last.id
               },
               employee_id: Employee.last.id
             }
      end.to(change { Project.count }.by(1)) &&
        redirect_to(Employee.last &&
        have_http_status(302)) &&
        render_template('show') &&
        eq(Employee.last) &&
        (expect(Employee.last.projects.last.repository).to eq('https://site.com'))
    end
  end
  describe 'POST #create with nested_attributes' do
    it 'returns a success response' do
      expect do
        post :create,
             params: {
               project: {
                 name: 'qweqwe',
                 employee_id: Employee.last.id
               },
               employee_id: Employee.last.id,
               image: {
                 image: 'image1'
               },
               skills: {
                 skill: {
                   name: 'skill1'
                 },
                 skill: {
                   name: 'skill2'
                 }
               }
             }
      end.to(change { Project.count }.by(1)) &&
        change { Skill.count }.by(2) &&
        change { Image.count }.by(1) &&
        change { Employee.last.skills.count }.by(2)
    end
  end

  describe 'PATCH #update' do
    it 'returns a success response' do
      patch :update,
            params: {
              id: Project.last.id,
              project: {
                repository: 'https://site2.com',
                employee_id: Employee.last.id,
                name: 'qweqwe',
                description: 'qweqwe'
              },
              employee_id: Employee.last.id
            }
      expect(response.status).to eq(302)
      expect(redirect_to(Employee.last)).to be_truthy
      expect(Project.last.name).to eq('qweqwe')
      expect(Employee.last.projects.last.repository).to eq('https://site2.com')
    end
  end

  describe 'GET #destroy' do
    it 'returns a success response' do
      expect do
        post :destroy,
             params: {
               id: Project.last.id,
               employee_id: Employee.last.id
             }
      end.to(change { Project.count }.by(-1)) &&
        redirect_to(Employee.last &&
        have_http_status(302)) &&
        render_template('show') &&
        eq(Employee.last)
    end
  end
end
