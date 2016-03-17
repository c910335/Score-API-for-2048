module WWW2048
   class V1 < Grape::API
      format :json
      content_type :json, 'application/json; charset=utf-8'

      helpers HTTP::Error::Helpers
      helpers do
         def request
            @request ||= ::Rack::Request.new(env)
         end

         def error! message, error_code, headers = nil
            V1.logger.error "{:path=>#{request.path}, :params=>#{request.params.to_hash}, :method=>#{request.request_method}, :message=>#{message}, :status=>#{error_code}}"
            super message, error_code, headers
         end
      end

      rescue_from RuntimeError do |e|
         V1.logger.error e
         error! 'Internal Server Error', 500
      end

      resource :player do

         desc 'Creates a player.' do
            success Entities::PlayerWithToken
            params Entities::Player.documentation.except(:id)
         end
         post do
            present DB::Player.create!(name: params[:name], token: SecureRandom.urlsafe_base64, score: params[:score])
         end

         desc 'Return players.' do
            success Entities::Players
         end
         get do
            present DB::Player.order(score: :desc), with: Entities::Players
         end

         route_param :token do

            desc 'Updates a player.' do
               success Entities::Player
               params Entities::Player.documentation.except(:id)
            end
            put do
               not_found! 'Player' unless player = DB::Player.find_by(token: params[:token])
               player.update!(name: params[:name], score: params[:score])
               present player, with: Entities::Player
            end

            desc 'Deletes a player.' do
               success Entities::Player
            end
            delete do
               not_found! 'Player' unless player = DB::Player.find_by(token: params[:token])
               present player.destroy!, with: Entities::Player
            end

         end

      end

      add_swagger_documentation api_version: 'v1',
                                hide_documentation_path: true,
                                hide_format: true,
                                mount_path: '/doc',
                                base_path: "#{Settings::API_URL}/2048/v1"
   end
end
