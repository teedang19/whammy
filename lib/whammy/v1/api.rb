module Whammy
  class V1::Api < Grape::API
    version 'v1', using: :header, vendor: 'whammy'
    format :json
    prefix 'api/v1'
  end
end