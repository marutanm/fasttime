# Connection.new takes host, port

host = 'localhost'
port = 27017

database_name = case Padrino.env
  when :development then 'fast_time_development'
  when :production  then 'fast_time_production'
  when :test        then 'fast_time_test'
end

# Use MONGO_URI if it's set as an environmental variable
Mongoid::Config.sessions =
  if ENV['MONGOLAB_URI']
    {default: {uri: ENV['MONGOLAB_URI'] }}
  else
    {default: {hosts: ["#{host}:#{port}"], database: database_name}}
  end

Mongoid.raise_not_found_error = false

# If you want to use a YML file for config, use this instead:
#
#   Mongoid.load!(File.join(Padrino.root, 'config', 'database.yml'), Padrino.env)
#
# And add a config/database.yml file like this:
#   development:
#     sessions:
#       default:
#         database: fast_time_development
#         hosts:
#           - localhost:27017 
#   production:
#     sessions:
#       default:
#         database: fast_time_production
#         hosts:
#           - localhost:27017
#   test:
#     sessions:
#       default:
#         database: fast_time_test
#         hosts:
#           - localhost:27017
#
#
# More installation and setup notes are on http://mongoid.org/en/mongoid/docs/installation.html#configuration
