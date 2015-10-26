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

    describe 'POST#create' do 
      it 'saves a chore with valid attributes to the database' do 
        expect{
          post :create, household_id: @test_household, chore: attributes_for(:chore)
          }.to change(Chore, :count).by(1)
      end

      it 'does not save a chore with invalid attributes' do 
        expect{
          post :create, household_id: @test_household, chore: attributes_for(:invalid_chore)
          }.to_not change(Chore, :count)
      end

      it 'saves a valid chore to the correct household' do
        old_count = @test_household.chores.count 
        post :create, household_id: @test_household, chore: attributes_for(:chore)
        @test_household.reload
        new_count = @test_household.chores.count
        expect(new_count - old_count).to eq(1)
      end

      it ' does not saves an invalid chore to the correct household' do
        old_count = @test_household.chores.count 
        post :create, household_id: @test_household, chore: attributes_for(:invalid_chore)
        @test_household.reload
        new_count = @test_household.chores.count
        expect(new_count - old_count).to eq(0)
      end
    end
  end

  describe 'non member access' do 
    before :each do 
      stub_current_user(@test_non_member)
      stub_authorize_user!
    end

    describe 'GET#new' do 
      it 'redirects to the search page if user has no household' do
        get :new, household_id: @test_household
        expect(response).to redirect_to households_path
      end

      it 'redirects to the users own household page if user has a household' do
        @new_household = create(:household, 
                                head_of_household: @test_non_member)
        @new_household.members << @test_non_member
        get :new, household_id: @test_household
        expect(response).to redirect_to @new_household
      end

      it 'renders a flash error' do 
        get :new, household_id: @test_household
        expect(flash[:error]).to be_present
      end
    end

    describe 'POST#create' do 
      it 'does not save a chore with valid attributes to the database' do 
        expect{
          post :create, household_id: @test_household, chore: attributes_for(:chore)
        }.to_not change(Chore, :count)
      end

      it 'does not save a chore with valid attributes to a household' do 
        old_count = @test_household.chores.count 
        post :create, household_id: @test_household, chore: attributes_for(:chore)
        @test_household.reload
        new_count = @test_household.chores.count
        expect(new_count - old_count).to eq(0)
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