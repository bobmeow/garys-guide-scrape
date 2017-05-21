require 'nokogiri'
require 'open-uri'

def getJobs
  arrayOfJobs = []
  base_url = 'http://www.garysguide.com'
  main_url = "#{base_url}/jobs?category=programming&type=&region=newyork"
  data = Nokogiri::HTML(open(main_url))
  all_sections = data.css('table > tr > td > table > tr > td:nth-child(3) > table > tr')
  sections = all_sections.slice(2..all_sections.length)

  counter1 = 0
  counter2 = 0

  while counter1 < sections.length - 1
    if counter2 == 0
      date = sections[counter1].text
    elsif counter2 == 1
      font_section_length = sections[counter1].css('font').length
      font_counter1 = 0
      font_counter2 = 0
      while font_counter1 < font_section_length
        if !sections[counter1].css('font')[font_counter1].text
          break
        end
        if font_counter2 == 0
          role = sections[counter1].css('font')[font_counter1].text.strip
          url = "#{base_url}#{sections[counter1].css('font')[font_counter1].at_css('a')['href']}"
        elsif font_counter2 == 1
          company = sections[counter1].css('font')[font_counter1].text.strip
        end
        font_counter1 += 1
        font_counter2 += 1
        if font_counter2 > 2
          arrayOfJobs << {
            date: date,
            role: role,
            url: url,
            company: company
          }
          font_counter2 = 0
        end
      end
    end
    counter1 += 1
    counter2 += 1
    if counter2 > 2
      counter2 = 0
    end
  end
  arrayOfJobs
end
