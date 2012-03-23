require 'bundler'
require 'toto'
require 'coderay'
require 'rack/codehighlighter'
require 'newrelic_rpm'


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
  set :title,     "Sean's Sphere"                   # site title
  set :root,      "index"                                   # page to load on /
  # set :date,      lambda {|now| now.strftime("%d/%m/%Y") }  # date format for articles
  set :markdown,  :smart                                    # use markdown + smart-mode
  set :url,  "http://seanlin.me"
  set :summary,   :max => 300, :delim => /~\n/              # length of article summary and delimiter
  set :ext,       'txt'                                     # file extension for articles
  set :cache,      28800                                  # cache duration, in seconds
  set :date, lambda {|now| now.strftime("%B #{now.day.ordinal} %Y") }
  set :to_html   do |path, page, ctx|                         # returns an html, from a path & context
    ERB.new(File.read("#{path}/#{page}.rhtml")).result(ctx)
  end
  set :error     do |code|                                    # The HTML for your error page
    "<font style='font-size:300%'>Opps, an error and it's probably my bad! (#{code})</font>"
  end
end



run toto


