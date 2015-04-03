module Whammy
  module V1
    require 'grape'

    class API < Grape::API
      version 'v1', using: :header, vendor: 'whammy'
      format :json
      prefix 'api/v1'
    end
  end
end