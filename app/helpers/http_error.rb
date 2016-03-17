module HTTP
   module Error
      module Helpers
         def not_found! thing = nil
            if thing
               error! "#{thing} Not Found", 404
            else
               error! 'Not Found', 404
            end
         end

         def forbidden!
            error! 'Forbidden', 403
         end
      end
   end
end
