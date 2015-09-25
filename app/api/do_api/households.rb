module DoApi
  class Households < Grape::API
    resources :households do
      desc 'Returns all households'
      get do
        Household.all
      end

      get ':id' do 
        Household.find_by(id: params[:id])
      end
    end
  end
end