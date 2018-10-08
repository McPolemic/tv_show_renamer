require 'fileutils'

SHOWS = {
  /American\.Horror\.Story\.S(\d+)E(\d+).+/            => "American Horror Story/Season $1/Episode $2/",
  /Archer\..+\.S(\d+)E(\d+).+/                         => "Archer/Season $1/Episode $2/",
  /Arrow\.S(\d+)E(\d+).+/                              => "Arrow/Season $1/Episode $2/",
  /Bones\.S(\d+)E(\d+).+/                              => "Bones/Season $1/Episode $2/",
  /Brooklyn\.Nine-Nine\.S(\d+)E(\d+).+/                => "Brooklyn Nine-Nine/Season $1/Episode $2/",
  /Dancing\.With\.The\.Stars.+S(\d+)E(\d+).+/          => "Dancing with the Stars/Season $1/Episode $2/",
  /Doctor\.Who.+\.S(\d+)E(\d+).+/                      => "Doctor Who/Season $1/Episode $2/",
  /Doctor_Who_\d+\.(\d+)x(\d+).+/                      => "Doctor Who/Season $1/Episode $2/",
  /DCs.Legends.of.Tomorrow.S(\d+)E(\d+).+/             => "DCs Legends of Tomorrow/Season $1/Episode $2/",
  /Family\.Guy\.S(\d+)E(\d+).+/                        => "Family Guy/Season $1/Episode $2/",
  /Game\.of\.Thrones\.S(\d+)E(\d+).+/                  => "Game of Thrones/Season $1/Episode $2/",
  /Greys\.Anatomy\.S(\d+)E(\d+).+/                     => "Grey's Anatomy/Season $1/Episode $2/",
  /IZombie\.S(\d+)E(\d+).+/                            => "IZombie/Season $1/Episode $2/",
  /Last.Week.Tonight.With.John.Oliver\.S(\d+)E(\d+).+/ => "Last Week Tonight/Season $1/Episode $2/",
  /Marvels.Agents.of.S.H.I.E.L.D.S(\d+)E(\d+).+/       => "Marvel's Agents of S.H.I.E.L.D./Season $1/Episode $2/",
  /Mike.and.Molly.S(\d+)E(\d+).+/                      => "Mike and Molly/Season $1/Episode $2/",
  /Mr\.Robot.S(\d+)E(\d+).+/                           => "Mr. Robot/Season $1/Episode $2/",
  /MythBusters.S(\d+)E(\d+).+/                         => "MythBusters/Season $1/Episode $2/",
  /Narcos\.S(\d+)E(\d+).+/                             => "Narcos/Season $1/Episode $2/",
  /NCIS\.S(\d+)E(\d+).+/                               => "NCIS/Season $1/Episode $2/",
  /Once.Upon.a.Time.S(\d+)E(\d+).+/                    => "Once Upon a Time/Season $1/Episode $2/",
  /Once\.Upon\.A\.Time\.S(\d+)E(\d+).+/                => "Once Upon a Time/Season $1/Episode $2/",
  /QI.S(\d+)E(\d+).+/                                  => "QI/Season $1/Episode $2/",
  /Rick.and.Morty.S(\d+)E(\d+).+/                      => "Rick and Morty/Season $1/Episode $2/",
  /Robot.Chicken.S(\d+)E(\d+).+/                       => "Robot Chicken/Season $1/Episode $2/",
  /Scream\.Queens\.2015\.S(\d+)E(\d+).+/               => "Scream Queens/Season $1/Episode $2/",
  /So.You.Think.You.Can.Dance\.S(\d+)E(\d+).+/         => "So You Think You Can Dance/Season $1/Episode $2/",
  /Stan\.Against\.Evil\.S(\d+)E(\d+).+/                => "Stan Against Evil/Season $1/Episode $2/",
  /Star\.Trek\.Discovery\.S(\d+)E(\d+).+/              => "Star Trek - Discover/Season $1/Episode $2/",
  /Supernatural\.S(\d+)E(\d+).+/                       => "Supernatural/Season $1/Episode $2/",
  /Supergirl\.S(\d+)E(\d+).+/                          => "Supergirl/Season $1/Episode $2/",
  /The.Expanse.S(\d+)E(\d+).+/                         => "The Expanse/Season $1/Episode $2/",
  /The\.Big\.Bang\.Theory\.S(\d+)E(\d+).+/             => "The Big Bang Theory/Season $1/Episode $2/",
  /The\.Handmaids\.Tale\.S(\d+)E(\d+).+/               => "The Handmaid's Tale/Season $1/Episode $2/",
  /The\.Flash\.2014\.S(\d+)E(\d+).+/                   => "The Flash/Season $1/Episode $2/",
  /The\.Good\.Place\.S(\d+)E(\d+).+/                   => "The Good Place/Season $1/Episode $2/",
  /The\.Grand\.Tour\.S(\d+)E(\d+).+/                   => "The Grand Tour/Season $1/Episode $2/",
  /The\.Magicians\.US\.S(\d+)E(\d+).+/                 => "The Magicians/Season $1/Episode $2/",
  /The\.Vampire\.Diaries\.S(\d+)E(\d+).+/              => "The Vampire Diaries/Season $1/Episode $2/",
  /The\.Walking\.Dead\.S(\d+)E(\d+).+/                 => "The Walking Dead/Season $1/Episode $2/",
  /This\.Is\.Us\.S(\d+)E(\d+).+/                       => "This is Us/Season $1/Episode $2/",
  /Top\.Gear\.S(\d+)E(\d+).+/                          => "Top Gear/Season $1/Episode $2/",
  /iZombie\.S(\d+)E(\d+).+/                            => "iZombie/Season $1/Episode $2/",
  /Westworld\.S(\d+)E(\d+).+/                          => 'Westworld/Season $1/Episode $2/',
  /Vikings\.S(\d+)E(\d+).+/                            => 'Vikings/Season $1/Episode $2/',
}

def move(src, dest)
  puts "Creating #{dest}..."
  FileUtils.mkdir_p(dest)
  puts "Moving #{src} to #{dest}..."
  FileUtils.mv(src, dest, force: true)
rescue Errno::EACCES => e
  puts "Permission denied when moving #{src} to #{dest}"
rescue => e
  puts "Error #{e.inspect} found"
end

def main(watch_dir, output_dir)
  Dir.entries(watch_dir).each do |name|
    SHOWS.each do |show|
      pattern = show.first
      result = show.last

      matches = name.match(pattern)
      next unless matches
      puts "Found match for #{pattern.inspect}: #{name}"
      (1..10).each do |i|
        result = result.gsub("$#{i}", matches[i]) unless matches[i].nil?
      end

      source = File.join(watch_dir, name)
      output = File.join(output_dir, result)
      puts "Sending #{name.inspect} to #{result.inspect}"
      move(source, output)
    end
  end
end

def usage()
  puts "#{$0} <download_dir> <output_dir>"
  puts "Views all directories in <download_dir> and renames those matching and"
  puts "moves them to <output_dir>."
  exit
end

if __FILE__ == $0
  usage() unless ARGV.count == 2
  watch_dir = ARGV[0]
  output_dir = ARGV[1]
  main(watch_dir, output_dir)
end
