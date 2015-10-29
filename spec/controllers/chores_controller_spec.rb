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

      it 'redirects if chore does not belong to household' do 
        @new_household = create(:household, head_of_household: @test_member)
        get :edit, household_id: @new_household, id: @test_chore
        expect(response).to redirect_to @new_household
      end

      it 'renders the edit template' do 
        get :edit, household_id: @test_household, id: @test_chore
        expect(response).to render_template :edit
      end
    end

    describe 'PATCH#update' do 
      before :each do 
        @old_name = @test_chore.name
        @new_name = @test_chore.name
        while @new_name == @old_name do 
          @new_name = Faker::Team.name
        end
      end

      it 'saves changes to the chore with valid attributes' do 
        patch :update, household_id: @test_household, id: @test_chore,
        chore: attributes_for(:chore, name: @new_name)
        @test_chore.reload
        expect(@test_chore.name).to eq(@new_name)
      end

      it 'does not save changes to chore with invalid attributes' do
         patch :update, household_id: @test_household, id: @test_chore,
        chore: attributes_for(:invalid_chore)
        @test_chore.reload
        expect(@test_chore.name).to eq(@old_name)
      end
    end

    describe 'DELETE#destroy' do 
      it 'removes the chore from the database if chore is not assigned to them' do
        expect{
          delete :destroy, household_id: @test_household, id: @test_chore
        }.to change(Chore, :count).by(-1)
      end

      it 'removes the chore from the household if chore is not assigned to them' do 
        delete :destroy, household_id: @test_household, id: @test_chore
        @test_household.reload
        expect(@test_household.chores).to_not include (@test_chore)
      end

      it 'redirects to the household page if chore is not assigned to them' do
        delete :destroy, household_id: @test_household, id: @test_chore
        expect(response).to redirect_to @test_household
      end

      xit 'does not remove the chore from the database if chore is assigned to them' do
        expect{
          delete :destroy, household_id: @test_household, id: @test_chore
        }.to_not change(Chore, :count)
      end

      xit 'does not remove the chore from the household if chore is assigned to them' do 
        delete :destroy, household_id: @test_household, id: @test_chore
        @test_household.reload
        expect(@test_household.chores).to include (@test_chore)
      end

      xit 'renders a flash error notice if chore is assigned to them' do
        delete :destroy, household_id: @test_household, id: @test_chore
        expect(flash[:error]).to be_present
      end
    end

    describe 'PUT#assign' do 
      it 'adds the chore to the list of current users chores' do 
        put :assign, household_id: @test_household, id: @test_chore
      expect(@test_member.chores).to include @test_chore
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
        get :edit, household_id: @test_household, id: @test_chore
        expect(response).to redirect_to @new_household
      end

      it 'redirects to the household search page if use does not have a household' do 
        get :edit, household_id: @test_household, id: @test_chore
        expect(response).to redirect_to households_path
      end
    end

    describe 'PATCH#update' do 
      before :each do 
        @old_name = @test_chore.name
        @new_name = @test_chore.name
        while @new_name == @old_name do 
          @new_name = Faker::Team.name
        end
      end

      it 'does not save changes to chore with valid attributes' do
         patch :update, household_id: @test_household, id: @test_chore,
        chore: attributes_for(:chore, name: @new_name)
        @test_chore.reload
        expect(@test_chore.name).to eq(@old_name)
      end

      it 'redirects to the users own household if use has a household' do 
        @new_household = create(:household, 
                                head_of_household: @test_non_member)
        @new_household.members << @test_non_member
        patch :update, household_id: @test_household, id: @test_chore,
        chore: attributes_for(:chore, name: @new_name)
        expect(response).to redirect_to @new_household
      end

      it 'redirects to the household search page if use does not have a household' do 
        patch :update, household_id: @test_household, id: @test_chore,
        chore: attributes_for(:chore, name: @new_name)
        expect(response).to redirect_to households_path
      end
    end

    describe "PUT#assign" do 
      it 'does not change the current users chores' do 
        chores = @test_non_member.chores
        put :assign, household_id: @test_household, id: @test_chore
        @test_non_member.reload
        expect(@test_non_member.chores).to eq chores
      end

      it 'renders a flash rerror messages' do 
        put :assign, household_id: @test_household, id: @test_chore
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

    describe 'GET#edit' do 
      it 'redirects to the home page' do 
        get :edit, household_id: @test_household, id: @test_chore
        expect(response).to redirect_to root_path
      end
    end
  end

end