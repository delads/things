
require 'mqtt'
require 'net/https'
require 'uri'

# Subscribe example
Thread.new do
  
  user = "1461c437"
  password = "8f2cf8f35b34ee39"
  namespace = "delads/nestX"
  
  MQTT::Client.connect('mqtt://' + user + ':' + password + '@broker.shiftr.io') do |c|
      
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
          
          thermostats = Thermostat.where("mqtt_user = ? AND mqtt_password = ? AND namespace = ?", user, password, namespace)
          thermostats.each do |thermostat|
            thermostat.update_attribute(:temperature, message)
          end
          
          
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
