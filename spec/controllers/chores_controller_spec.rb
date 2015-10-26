require 'rails_helper'

describe ChoresController do 
  before :each do 
    @test_member = create(:user)
    @test_non_member = create(:user)
    @test_household = create(:household, head_of_household: @test_member)
    @test_household.members << @test_member
    @test_chore = create(:chore, household: @test_household)
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

    describe 'GET#edit' do 
      it 'assigns the correct Household to @household' do 
        get :edit, household_id: @test_household, id: @test_chore
        expect(assigns(:household)).to eq(@test_household)
      end

      it 'assigns the correct Chore to @chore' do 
        get :edit, household_id: @test_household, id: @test_chore
        expect(assigns(:chore)).to eq(@test_chore)
      end

      it 'renders the edit template' do 
        get :edit, household_id: @test_household, id: @test_chore
        expect(response).to render_template :edit
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

    describe 'GET#edit' do 
      it 'redirects to the users own household if use has a household' do 
        @new_household = create(:household, 
                                head_of_household: @test_non_member)
        @new_household.members << @test_non_member
        @new_chore = create(:chore, household: @new_household)
        get :edit, household_id: @test_household, id: @test_chore
        expect(response).to redirect_to @new_household
      end

      it 'redirects to the household search page if use does not have a household' do 
        get :edit, household_id: @test_household, id: @test_chore
        expect(response).to redirect_to households_path
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