class API < Grape::API
  prefix :api
  format :json
  mount DoApi::Users
  mount DoApi::Households
end