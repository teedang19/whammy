module Whammy
  module V1
    require 'grape'

    class API < Grape::API
      version 'v1', using: :path, vendor: 'whammy'
      format :json
      prefix :api

      namespace :records do
        desc "post a record"
        params do
          requires :record, type: Hash do
            requires :last_name, type: String
            requires :first_name, type: String
            requires :gender, type: String
            requires :favorite_color, type: String
            requires :date_of_birth, type: String
          end
        end
        post do
          Database.new.write_line(params[:record])
        end

        desc "return records sorted by gender, women first && last name ascending"
        get :gender do
          { records: Sorter.new.sort!(:gender) }
        end

        desc "return records sorted by birthdate, oldest first"
        get :birthdate do
          { records: Sorter.new.sort!(:birthdate) }
        end

        desc "return records sorted by last name, descending"
        get :name do
          { records: Sorter.new.sort!(:last_name) }
        end
      end
    end
  end
end