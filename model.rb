class ShortenedUrl
  include DataMapper::Resource

  property :id, Serial
  property :url, Text
  property :to, Text
  property :id_usu, Text

  #has n, :visits
end

=begin
class Visit 
	include DataMapper::Resource

	property :id,	Serial
	property :created_at,	DateTime
	property :ip,	IPAddress
	property :country,	String
	belongs_to :link

	after :create, :set_country

	def set_country
		xml = RestClient.get "http://api.hostip.info/get_xml.php?ip=#{ip}"··
    	self.country = XmlSimple.xml_in(xml.to_s, ...
    	self.save
  	end
  
end =end 