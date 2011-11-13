require 'rubygems'
require 'date'

class DriverLicenseParser
  
  # Takes an array of drivers licenses
  
  def initialize(license=[])
    @license = license
    parse_mag_strip
  end
  
  def first_name
    @first_name
  end
  
  def last_name
    @last_name
  end
  
  def middle_name
    @middle_name
  end
  
  def address_1
    @street_address
  end
  
  def city
    @city
  end
  
  def state
    @state
  end
  
  def zip
    @zip   
  end
  
  def date_of_birth
    date = "#{birth_year}-#{birth_month}-#{birth_day}"
    Date.parse(date)
  end
  
  def birth_month
    @birth_month
  end
  
  def birth_year
    @birth_year
  end
  
  def birth_day
    @birth_day
  end
  
  def expires
    date = "20#{@expires_year}-#{birth_month}-#{birth_day}"
    Date.parse(date)
  end
  
  def license_class
    @license_class
  end
  
  def license_number
    "#{@dl_letter}#{@license_num}"
  end
  
  def sex
    @sex
  end
  
  def dimension
    {:feet => @ft, :inches => @in }
  end
  
  def hair_color
    @hair_color
  end
  
  def eyes_color
    @eyes_color
  end
  
  def lbs
    @lbs
  end
  
  def to_s
    "Drivers License: #{license_number}\nFirst Name: #{first_name} \nLast Name: #{last_name} \nAddress: #{address_1} \nCity: #{city} \nState: #{state} \nZip: #{zip} \nDOB: #{date_of_birth} \nExpires: #{expires} \nLicense Class: #{license_class} \nSex: #{sex} \nHair Color: #{hair_color} \nEyes Color: #{eyes_color} \nDimension: #{dimension[:feet]}' #{dimension[:inches]}\" \nWeight: #{lbs}\n\n"
  end
    
  def days_old
    (Date.today - date_of_birth).to_i    
  end
  
  def years_old
    days_old.to_i / 365
  end
  
  def can_drink?
    if years_old > 21
      true
    else
      false
    end
  end
  
  def can_smoke?
    if years_old > 18
      true
    else
      false
    end
  end
  
private
  def parse_mag_strip
      trk = @license.split('?')
      flds = trk[0].split('^')
      @state = flds[0][1,2]  
      @city = flds[0][3,99]      
      name = flds[1].split('$')
      @last_name = name[0]
      @first_name = name[1]
      @middle_name= name[2]
      @zip = trk[2][3,10]
      @street_address = flds[2]
      
      @date_of_birth = trk[1][19..24]
      @birth_month = @date_of_birth[0..1]
      @birth_year = @date_of_birth[2..5]
      @birth_day = trk[1][27..29]
      @expires_year = trk[1][17..18]
      @license_num = trk[1][9..15]
      
      other_info = trk[2].gsub(/ /,'')
      
      @license_class = other_info[8..8]
      @sex = other_info[9..9]
      @ft = other_info[10..10]
      @in = other_info[11..12]
      
      @hair_color = other_info[16..18]
      @eyes_color = other_info[19..21]
      @dl_letter = other_info[22..22]
      @lbs = other_info[13..15]
  end

end




