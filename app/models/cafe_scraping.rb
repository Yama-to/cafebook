require 'mechanize'

class Cafe
  HOST_NAME  = 'http://seattlecoffeescene.com/seattles-50-best-coffeehouses-in-2013/'
  # FIRST_PAGE = 'street.php?sex=cafe'
  START_M    = 'Now importing...'
  # LINE_L     = '//---------------//---------------//---------------//---------------//'
  LINE_S     = '--------------------------------------------<'
  @@cafe_box = []
  @@img_box  = []
  @@add_box  = []
  @@agent    = Mechanize.new

  def initialize
    @working_dir = Mechanize.new.get(HOST_NAME)
    # reset_working_dir
    goto_next_page
  end

  def goto_next_page
    puts START_M
    get_cafes_data
    # save_cafes
    # puts_cafes_info ##output on console
  end

  private

  # def reset_working_dir
  #   @working_dir = @@agent.get(HOST_NAME)
  # end

  def get_cafes_data
    cafes   = @working_dir.search('h2:not(#site-description)')
    puts cafes.count
    images  = @working_dir.search('p > img.aligncenter')
    puts images.count
    address = @working_dir.search('span>span')
    puts address.count
    puts "=============================="

    cafes.each do |c|
      @@cafe_box << c.inner_text.gsub(/(^\d+.| - .+$)/, '')
    end
    puts @@cafe_box

    images.each do |c|
      @@img_box  << c[:src]
    end
    puts @@img_box

    address.each do |c|
      @@add_box  << c.inner_text
    end
    puts @@add_box
  end

  def save_cafes
    @@cafe_box.each do |g|
      next if g == nil || g.class != cafe
      g.save
    end
  end

  def puts_cafes_info
    num  = 0
    @@cafe_box.each do |g|
      # next if g == nil || g.class != cafe
      puts g
      puts @@img_box[num]
      puts @@add_box[num]

      num += 1
    end
  end
end

Cafe.new ##start cafes scraping