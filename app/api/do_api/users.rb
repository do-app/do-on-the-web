module DoApi
  class Users < Grape::API
      # desc 'Returns all users'
    resources :users do
      get do
        User.all
      end

      get ':id' do 
        User.find_by(id: params[:id])
      end
    end
  end
end