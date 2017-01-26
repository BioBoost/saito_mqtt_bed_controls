require 'pi_piper'
require 'mqtt'
include PiPiper

puts "Starting ..."

client = MQTT::Client.connect(:host => '10.0.0.100', :port => 1883)

json_yellow = '{"color": {"r": 225, "b": 0, "g": 255}, "state": "ON", "brightness": 100}'
json_pink = '{"color": {"r": 225, "b": 255, "g": 0}, "state": "ON", "brightness": 100}'

watch :pin => 17, :direction => :in, :pull => :off do
  puts "Pin 17 changed from #{last_value} to #{value}"
  if (value == 1)
    client.publish('saito/bed/neopixels/set', json_pink, retain=true)
  end
end

watch :pin => 27, :direction => :in, :pull => :off do
  puts "Pin 27 changed from #{last_value} to #{value}"

  if (value == 1)
    client.publish('saito/bed/neopixels/set', json_pink, retain=true)
  end
end

PiPiper.wait
