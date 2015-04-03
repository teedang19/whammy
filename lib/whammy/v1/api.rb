module Whammy
  module V1
    require 'grape'

    class API < Grape::API
      version 'v1', using: :path, vendor: 'whammy'
      format :json
      prefix :api
    end
  end
end