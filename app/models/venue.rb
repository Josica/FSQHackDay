class Venue < ApplicationRecord
  def self.search(search_param)
    CLIENT = Foursquare2::Client.new(:client_id => 'ZFIDFGPQ1UTJ3SAVIXZF4U2RGFBNXKURSWFWKLU2NLIRF5HR', :client_secret => '1OECASC505PMAROODFKPJHU51QDHRYRNVZHD0BB04Z00MC24',:v => '20170101')
    search_results = []
    response = CLIENT.search_venues(:ll => @coordinates, :query => @query, :limit => 10, :radius => 1000, :v => @version)
    response["venues"].each do |biz|
     distance = (biz["location"]["distance"].to_f * 3.28084)
       if distance > 1000
         distance = "#{(distance * 0.000189394).to_s.slice(0,3)} miles"
       else
         distance = "#{distance.to_i} ft"
       end
     address = biz["location"]["formattedAddress"]
     search_result_coords = [biz["location"]["lat"], biz["location"]["lng"]]
     search_results.insert(biz["location"]["distance"], [biz["name"], biz["hereNow"]["count"], "http://www.foursquare.com/venue/#{biz['id']}", address, distance, search_result_coords])
     # search_results << [biz["name"], biz["hereNow"]["count"], "http://www.foursquare.com/venue/#{biz['id']}", address, distance, search_result_coords]
   end
    # binding.pry
   [search_results.compact[0]]
   # search_results
  end
end
