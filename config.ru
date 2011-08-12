require 'bundler'
Bundler.require

require 'toto'
require 'coderay'
require 'rack/codehighlighter'


# Rack config

use Rack::Static, :urls => ['/css', '/js', '/images', '/favicon.ico'], :root => 'public'
use Rack::Codehighlighter, :coderay, :markdown => true, :element => "pre>code", :pattern => /\A:::(\w+)\s*(\n|&#x000A;)/i, :logging => true
CodeRay::Encoders["html"]::DEFAULT_OPTIONS[:line_numbers]=:inline
use Rack::CommonLogger

if ENV['RACK_ENV'] == 'development'
  use Rack::ShowExceptions
end

#
# Create and configure a toto instance
#
toto = Toto::Server.new do
  #
  # Add your settings here
  # set [:setting], [value]
  # 
  set :author,  "Sean Lin"                              # blog author
  set :title,     "SeanSphere"                   # site title
  # set :root,      "index"                                   # page to load on /
  # set :date,      lambda {|now| now.strftime("%d/%m/%Y") }  # date format for articles
  #set :markdown,  :smart                                    # use markdown + smart-mode
  # set :disqus,    false                                     # disqus id, or false
  set :summary,   :max => 300, :delim => /~/                # length of article summary and delimiter
  # set :ext,       'txt'                                     # file extension for articles
  set :cache,      28800                                    # cache duration, in seconds

  set :date, lambda {|now| now.strftime("%B #{now.day.ordinal} %Y") }
end

run toto


