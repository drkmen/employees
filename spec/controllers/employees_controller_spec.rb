# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EmployeesController, type: :controller do
  let(:employee_1) { FactoryBot.create(:employee, office: 1, role: 1, department: 1) }
  let(:employee_2) { FactoryBot.create(:employee, office: 2, role: 2, department: 1) }
  let(:employee_3) { FactoryBot.create(:employee, office: 2, role: 3, department: 0) }
  let(:employee_4) { FactoryBot.create(:employee, office: 3, role: 4, department: 3) }
  let(:skill_1) { FactoryBot.create(:skill, name: 'API development', skill_type: 'other_skill') }
  let(:skill_2) { FactoryBot.create(:skill, name: 'AWS', skill_type: 'service') }
  let(:skill_3) { FactoryBot.create(:skill, name: 'Active Admin', skill_type: 'library') }

  context 'signed out' do
    it 'should be signed in' do
      get :index
      expect(response).to have_http_status(302)
      expect(response).to redirect_to new_employee_session_path
    end
  end

  context 'signed in developer' do
    before do
      @developer = FactoryBot.create(:employee, :developer)
      sign_in @developer
    end

    it 'is not allowed to see /index' do
      get :index
      expect(response).to have_http_status(302)
      expect(response).to redirect_to employee_path(@developer)
    end

    it 'is not allowed to see /show of other employees' do
      get :show, params: { id: employee_1.slug }
      expect(response).to have_http_status(302)
      expect(response).to redirect_to employee_path(@developer)
    end

    it 'is allowed to see /show himself' do
      get :show, params: { id: @developer.slug }
      expect(response).to have_http_status(200)
    end
  end

  context 'signed in admin' do
    before do
      @employee_admin = FactoryBot.create(:employee, :admin)
      sign_in @employee_admin
    end

    describe 'GET #index' do
      it 'returns a success response' do
        get :index
        expect(response.status).to eq(200)
        expect(response).to render_template('index')
        expect(assigns(:employees).size).to be 1
      end
    end

    describe 'GET #index with filters' do
      before do
        ResourceSkill.create(skill_id: skill_1.id, employee_id: employee_2.id, experience: 'bad')
        ResourceSkill.create(skill_id: skill_3.id, employee_id: employee_2.id, experience: 'good')
        ResourceSkill.create(skill_id: skill_1.id, employee_id: employee_3.id, experience: 'better than nothing')
        ResourceSkill.create(skill_id: skill_2.id, employee_id: employee_4.id, experience: 'best')
      end

      it 'only office' do
        get :index, params: { office: 2 }
        expect(assigns(:employees).size).to be 2
      end

      it 'office and role' do
        get :index, params: { office: 2, role: 3 }
        expect(assigns(:employees).size).to be 1
      end

      it 'all filters with skills' do
        get :index, params: { office: 2, role: 3, department: 0 }
        expect(assigns(:employees).size).to be 1
      end

      it 'returns a success response' do
        get :index, params: { skills: ['API development'] }
        expect(assigns(:employees).size).to be 2
      end

      it 'returns a success response' do
        get :index, params: { skills: ['AWS'] }
        expect(assigns(:employees).size).to be 1
      end

      it 'returns a success response' do
        get :index, params: { skills: ['Active Admin'] }
        expect(assigns(:employees).size).to be 1
      end

      it 'returns a success response' do
        get :index, params: { office: 2, skills: ['API development'] }
        expect(assigns(:employees).size).to be 2
      end

      it 'returns a success response' do
        get :index, params: { office: 3, role: 4, skills: ['AWS'] }
        expect(assigns(:employees).size).to be 1
      end

      it 'returns a success response' do
        get :index, params: { office: 2, role: 2,
                              department: 1, skills: ['Active Admin'] }
        expect(assigns(:employees).size).to be 1
      end
    end

    describe 'GET #show' do
      it 'returns a success response' do
        get :show, params: { id: Employee.last.to_param }
        expect(response.status).to eq(200)
        expect(response).to render_template('show')
        expect(assigns(:employee)).to eq(Employee.last)
      end

      it 'returns a success response with json format' do
        request.headers['HTTP_ACCEPT'] = 'application/json; charset=utf-8'
        get :show, params: { id: Employee.last.to_param }
        expect(response.status).to eq(200)
        expect(response).to render_template('show')
        expect(response.headers['Content-Type']).to eq('application/json; charset=utf-8')
        expect(assigns(:employee)).to eq(Employee.last)
      end
    end

    describe 'PUT #update' do
      it 'returns a success response' do
        put :update,
            params: {
              id: Employee.last.id,
              employee: {
                first_name: 'qweqwe',
                last_name: 'qweqwe'
              }
            }
        expect(response.status).to eq(302)
        expect(redirect_to(Employee.last)).to be_truthy
        expect(assigns(:employee)).to eq(Employee.last)
        expect(Employee.last.first_name).to eq('qweqwe')
        expect(Employee.last.last_name).to eq('qweqwe')
      end
    end

    describe 'Delete #destroy' do
      it 'returns a success response' do
        expect do
          post :destroy, params: { id: Employee.last.id }
        end.to(change { Employee.count }.by(-1)) &&
          have_http_status(302) &&
          render_template('index')
      end
    end

    describe 'PATCH #skill_experience' do
      before do
        ResourceSkill.create(skill_id: skill_3.id, employee_id: employee_2.id, experience: 'good', level: 100)
      end

      it 'returns a success response' do
        expect do
          patch :skill_experience,
                params: {
                  employee_id: employee_2.id,
                  skill_experience: {
                    id: ResourceSkill.last.id,
                    experience: 'better',
                    level: 24
                  }
                }
        end.to(change { ResourceSkill.last.experience }.to(eq('better')) &&
                   change { ResourceSkill.last.level }.to(eq(24))) &&
          have_http_status(302) &&
          render_template('show')
      end
    end
  end
end
