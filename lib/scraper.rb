require 'open-uri'
require 'nokogiri'
require 'pry'

index_url = "https://learn-co-curriculum.github.io/student-scraper-test-page/"

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = doc.css("div.student-card")
    students_array = []

    students.each do |student|
      student_name = student.css("h4.student-name").text
      students_array << {
        name: student.css("h4.student-name").text,
        location: student.css("p.student-location").text,
        profile_url: "#{student.css("a").attribute("href").text}"
      }
    end
    students_array
  end

  # profile_url = "https://learn-co-curriculum.github.io/student-scraper-test-page/students/ryan-johnson.html"
  
  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    profile_hash = {}

    doc.css("div.social-icon-container a").each do |account| 
      link = account.attribute("href").text
      if link.include?("twitter")
        profile_hash[:twitter] = link
      elsif link.include?("linkedin")
        profile_hash[:linkedin] = link
      elsif link.include?("github")
        profile_hash[:github] = link
      else 
        profile_hash[:blog] = link
      end
    end
    profile_hash[:profile_quote] = doc.css("div.profile-quote").text
    profile_hash[:bio] = doc.css("div.description-holder p").text
    profile_hash
  end
end


# binding.pry
0

#PROFILE SCRAPE
#twitter => doc.css("div.social-icon-container a").each do |account| account.attribute("href").text

#INDEX SCRAPE
#students => doc.css("div.student-card")
#name => css("h4.student-name").text
#location => css("p.student-location").text
#profile_url => .css("a").attribute("href").text
