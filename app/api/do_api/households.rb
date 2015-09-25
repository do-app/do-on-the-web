module DoApi
  class Households < Grape::API
    resources :households do
      desc 'Returns all households'
      get do
        Household.all
      end

      desc 'Returns a single household by id'
      get ':id' do 
        Household.find_by(id: params[:id])
      end
    end
  end
end