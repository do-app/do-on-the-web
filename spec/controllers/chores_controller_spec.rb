require 'rails_helper'

describe ChoresController do 
  before :each do 
    @test_head_of_household = create(:user)
    @test_member = create(:user)
    @test_non_member = create(:user)
    @test_household = create(:household, head_of_household: @test_head_of_household)
    @test_household.members << @test_member
    @test_household.members << @test_head_of_household
  end

  describe 'head of household access' do
    before :each do 
      stub_current_user(@test_head_of_household)
      stub_authorize_user!
    end
  end

  describe 'household member access' do 
    before :each do 
      stub_current_user(@test_member)
      stub_authorize_user!
    end

    describe 'GET#new' do 
      it 'assigns a the correct household to @household' do 
        get :new, household_id: @test_household
        expect(assigns[:household]).to eq @test_household
      end

      it 'assigns a new chore to @chore' do 
        get :new, household_id: @test_household
        expect(assigns[:chore]).to be_a_new(Chore)
      end

      it 'renders the new template' do 
        get :new, household_id: @test_household
        expect(response).to render_template :new
      end
    end
  end

  describe 'non member access' do 
    before :each do 
      stub_current_user(@test_non_member)
      stub_authorize_user!
    end

    describe 'GET#new' do 
      it 'redirects to the users own household page' do
        get :new, household_id: @test_household
        expect(response).to redirect_to households_path
      end

      it 'renders a flash error' do 
        get :new, household_id: @test_household
        expect(flash[:error]).to be_present
      end
    end
  end

  describe 'guest access' do 
    describe 'GET#new' do 
      it 'redirects to the home page' do 
        get :new, household_id: @test_household
        expect(response).to redirect_to root_path
      end
    end

  end

end