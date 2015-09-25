module DoApi
  class Users < Grape::API
    resources :users do
      desc 'Returns all users'
      get do
        User.all
      end

      desc 'Returns a single user by id'
      get ':id' do 
        User.find_by(id: params[:id])
      end
    end
  end
end