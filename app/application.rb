require "pry"
class Application
    @@items = []
 
    def call(env)
      resp = Rack::Response.new
      req = Rack::Request.new(env)
   
      if req.path.match(/items/)
        specific_item = req.path.split("/items/").last
        items = @@items.find{|item|item.name == specific_item}
        #binding.pry
        if items
           
            resp.write "#{items.name}"
            resp.write "#{items.price}"
        else
            resp.status = 400
            resp.write "Item not found"
        end
       
        
      else
        resp.write "Route not found"
        resp.status = 404
      end
   
      resp.finish
    end
  end