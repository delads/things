
require 'mqtt'
require 'net/https'
require 'uri'

# Subscribe example
Thread.new do
  MQTT::Client.connect('mqtt://1461c437:8f2cf8f35b34ee39@broker.shiftr.io') do |c|
      
       c.subscribe( 'temperature' )
       c.subscribe( 'turn_off_nest')
      
      # If you pass a block to the get method, then it will loop
      #c.get('temperature') do |topic,message|
      #  puts "#{topic}: #{message}"
      #end
      
      ## Let's send a trigger to IFTTT if max temp is reached
      c.get do |topic,message|
        puts "#{topic}: #{message}"
        
        
        
        if(topic == "temperature")
          # Let's update our database
          
          thermostat = Thermostat.first
          thermostat.update_attribute(:temperature, message)
     
          
        end
        
        
        if(topic == "turn_off_nest")
            uri = URI('https://maker.ifttt.com/trigger/nestX_hit_max_temp/with/key/n5xldM_GhWuUYTyJmpdtgibxnjO5Cx8VzbW6EaBCo1S')
            Net::HTTP.start(uri.host, uri.port,
            :use_ssl => uri.scheme == 'https') do |http|
                request = Net::HTTP::Get.new uri
                http.request request # Net::HTTPResponse object
            end
            puts ("Sent trigger to IFTTT");
        end
        
      end
  end
end
