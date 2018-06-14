require 'erb'
require 'uri'

dev_machine_reference = "localhost"
host_machine_reference = "10.0.2.2"

local_services = Hash.new( dev_machine_reference )
ARGV.each do |local_service|
  local_services[local_service] = host_machine_reference
end

template = ERB.new File.read("services_local_nginx.conf.erb"), nil, "%"
output = template.result(binding)

File.open('config/ui/services_local_nginx.conf', 'w+') do |f|
  f.write output
end