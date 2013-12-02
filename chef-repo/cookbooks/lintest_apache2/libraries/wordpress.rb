require 'open-uri'
module WordpressHelper
  def self.fetch_secret_keys
    open('http://api.wordpress.org/secret-key/1.1/') { |f| f.read }
  end
end
