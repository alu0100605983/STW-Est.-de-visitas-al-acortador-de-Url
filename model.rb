require 'dm-core'
require 'dm-migrations'
require 'restclient'
require 'xmlsimple'
require 'dm-timestamps'

class Shortenedurl
	include DataMapper::Resource
		property :id, Serial
		property :url, Text
		property :to, Text
		property :id_usu, Text

		has n, :visits
end

class Visit
	include DataMapper::Resource
		property  :id,          Serial
		property  :created_at,  DateTime
		property  :ip,          IPAddress
		property  :country,     Strin
		#belongs_to  :link
		belongs_to :shortenedur
		after :create, :set_country

	def set_country
		xml = RestClient.get "http://api.hostip.info/get_xml.php?ip=#{ip} #{self.ip}"
		self.country = XmlSimple.xml_in(xml.to_s, { 'ForceArray' => false })['country'].to_s
		self.save
	end

	def self.count_date(id)
  		repository(:default).adapter.select("SELECT date(created_at) AS date, count(*) AS count FROM visits WHERE url_identifier = '#{id}' GROUP BY date(created_at)")
	end

	def self.count_country(id)
		repository(:default).adapter.select("SELECT country, count(*) as count FROM visits where url_identifier = '#{id}' group by country")
	end
  
end