require './app/models/player'
require './app/helpers/http_error'
require './app/api/v1'

module WWW2048
   class API < Grape::API
      if $no_log
         ActiveRecord::Base.logger = nil
      else
         logger.formatter = GrapeLogging::Formatters::Default.new
         logger Logger.new GrapeLogging::MultiIO.new(STDOUT, File.open(Settings::LOG_PATH, 'a'))
         use GrapeLogging::Middleware::RequestLogger, { logger: logger }
      end
      mount WWW2048::V1 => '/2048/v1'
   end
end
