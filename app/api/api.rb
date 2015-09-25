class API < Grape::API
  prefix :api
  format :json
  mount DoApi::Users
end