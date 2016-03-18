module DB
   class Player < ActiveRecord::Base
   end
end

module Entities
   class Player < Grape::Entity
      expose :id, documentation: {type: 'integer', desc: 'identifier', required: true}
      expose :name, documentation: {type: 'string', desc: 'name', required: true}
      expose :score, documentation: {type: 'integer', desc: 'score', required: true}
   end

   class Players < Grape::Entity
      present_collection true, :players
      expose :players, using: Player
   end

   class PlayerWithToken < Player
      expose :token, documentation: {type: 'string', desc: 'token', required: true}
   end
end
