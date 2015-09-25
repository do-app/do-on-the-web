module DoApi
  class API < Grape::API
    prefix :api
    format :json

    resources :users do 
      # desc 'Returns all users'
      get do
        User.all
      end

      get ':id' do 
        User.find_by(id: params[:id])
      end
    end
    
  end
end