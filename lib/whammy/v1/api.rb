module Whammy
  module V1
    require 'grape'

    class API < Grape::API
      version 'v1', using: :path, vendor: 'whammy'
      format :json
      prefix :api

      namespace :records do
        # desc "post a record"
        # post do
        # end

        desc "return records sorted by gender, women first && last name ascending"
        get :gender do
        end

        desc "return records sorted by birthdate, oldest first"
        get :birthdate do
        end

        desc "return records sorted by last name, descending"
        get :name do
        end
      end
    end
  end
end