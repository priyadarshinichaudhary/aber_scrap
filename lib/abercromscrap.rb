require "abercromscrap/version"
require 'bundler/setup'
require 'nokogiri'
require 'open-uri'

module Abercromscrap
 class Scrap
 	def self.process
    url = "https://www.abercrombiekent.com/"
    doc = Nokogiri::HTML(open(url))
  	doc.css('.destinations a').each do |e|
  		begin
		   	url2="https://www.abercrombiekent.com#{e[:href]}"
				doc2 = Nokogiri::HTML(open(url2))
			rescue => error
				@invalid=Invalidinfo.create(:url=>url2,:msg=>error.message)
			end
			begin
			 url3="https://www.abercrombiekent.com#{doc2.at_css('#CS_Element_searchbtn .button')[:href]}"#&scp=#{i}"
			 doc3 = Nokogiri::HTML(open(url3))
				total_travels=doc3.css('.show-for-medium-up11 p').text.split(" ").last.to_f
				total_pages=round_off_to_next(total_travels,12)
				for i in 1..total_pages
	    		if i!=1
	    			url3_1= url3+"&scp=#{i}"
	    			doc3 = Nokogiri::HTML(open(url3_1))
	    		end
				  @tm=0
					doc3.css('.no_marg_bot a').each do |t|
						url4="https://www.abercrombiekent.com#{t[:href]}"
						@item={}
						@item["url"]=url4
						@item["city_id"]=url4.split("=").last
						if !Safari.exists?(:city_id=>@item["city_id"])
							doc4=Nokogiri::HTML(open(url4))
							begin
								@item["image"]=doc4.at_css('.small-12 img').present? ? doc4.at_css('.small-12 img')['src'].gsub("/assets_global/media/images","https://www.abercrombiekent.com/assets_global/media/images") : "n/a"
								@item["product_name"]=doc4.at_css('.small_marg_bot').present? ? doc4.at_css('.small_marg_bot').text.gsub("\n","") : "n/a"
								doc4.css('.no-pad-med .no_marg_top').each do |tag|
                  @tags=tag.text.gsub("\n","").gsub(" ","") 
                  @item["days"]=@tags.split('guests').last.split("Â").first.split(":").last
								  @item["pricing"]=@tags.split('|').last.split(":").last
								end
								@item[:product_type]="Tour"
								@item["description"]=doc4.at_css(".large_text p").present? ? doc4.at_css(".large_text").text : "n/a"
								url5="https://www.abercrombiekent.com/travel/?fuseaction=dsp_itinerary&tid=#{@item["city_id"]}"
								doc5 = Nokogiri::HTML(open(url5)) 
								begin
									@content=[]
				          @title=[]
				          @visit=[]
				          doc5.css(".itin_title").each do |e|
				          	@title<<e.text.gsub('  ','').gsub("\n",'')
				          end
				          doc5.css(".itin_text p").each do |e|
				            @content<<e.text.gsub('  ','').gsub("\n",'')
				          end
									@itineraries=[]
									for i in 0...@title.count
										iti={}
				           	@visit<<@title[i].split(':')[1]
				           	iti["#{@title[i].split(':')[0]}"]="Title: #{@title[i].split(':')[1]} , Description: #{@content[i]}"
				           	@itineraries<<iti
				           	@item["itinerary"]=@itineraries
				          end
				          @item["product_address"]= "You will visit : #{@visit.join(',')}"
			          rescue => error
				         @invalid=Invalidinfo.create(:url=>url5,:msg=>error.message)
			          end
						    url7="https://www.abercrombiekent.com/travel/?fuseaction=dsp_dates&tid=#{@item["city_id"]}"
						    doc7=Nokogiri::HTML(open(url7))
							  begin
								  @dates=[] 
								  @available=[]
								  @price_content=[]
								  @price_title=[]
								  @available_title=[]
								  @available_content=[]
								  @suppliment=[]
								  @suppliment_price=[]
								  @internal_air=[]
								  @internal_air_price=[]
								  doc7.css('.left.marg_right10').each do |e|
								  	@dates<<e.text.gsub('  ','').gsub("\n",'')
								  end
								  doc7.css('.room_name').each do |e|
				           @price_content<<e.text.gsub('  ','').gsub("\n",'')
								  end
								  doc7.css('.width127+ .width127 label').each do |e|
								  	@suppliment_price<<e.text.gsub('  ','').gsub("\n",'')
								  end
								  doc7.css('.width127+ .width116').each do |e|
								  	@internal_air_price<<e.text.gsub('  ','').gsub("\n",'').gsub("\\","")
								  end
								  doc7.css('.width116+ .width116 label').each do |e|
								  	@available_content<<e.text.gsub('  ','').gsub("\n",'')
								  end
								  @days=[]
								  for i in 0...@dates.count
								  	date={}
				           	date["date"]=@dates[i]
				           	date["price"]=@price_content[i]
				           	date["single_supplement"]=@suppliment_price[i]
				           	date["internal_air_from"]=@internal_air_price[i]
				           	date["available"]=@available_content[i]
				           	@days<< date
				           	@item["product_date"]=@days
				          end
				          Safari.create(@item)
				        rescue => error
				         @invalid=Invalidinfo.create(:url=>url7,:msg=>error.message)
				        end
			        rescue => error
				       @invalid=Invalidinfo.create(:url=>url4,:msg=>error.message)
						  end
						end 
					end	
				end	
			rescue => error
	      @invalid=Invalidinfo.create(:url=>url3,:msg=>error.message)
			end
  	end
  end
 end
end
