# frozen_string_literal: true

class Amplifier
  def initialize(description)
    @description = description
  end

  def amp_on
    puts "#{@description} on"
  end

  def amp_off
    puts "#{@description} off"
  end

  def setup_stereo_sound
    puts "#{@description} stereo mode on"
  end

  def setup_surround_sound
    puts "#{@description} surround sound on (5 speakers, 1 subwoofer)"
  end

  def setup_volume(level)
    puts "#{@description} setting volume to #{level}"
  end

  def setup_tuner(tuner)
    puts "#{@description} setting tuner to #{@tuner}"
    @tuner = tuner
  end

  def setup_dvd(dvd)
    puts "#{@description} setting DVD player to #{dvd.class}"
    @dvd = dvd
  end

  def setup_cd(cd)
    puts "#{@description} setting CD player to #{cd}"
    @cd = cd
  end
end

class DvdPlayer
  def initialize(description, amp)
    @description = description
    @amp = amp
  end

  def dvd_player_on

  end

  def dvd_player_off

  end

  def dvd_player_play(movie)

  end

  def dvd_player_eject

  end

  def dvd_player_stop

  end
end

class CdPlayer
  def initialize(description, amp)
    @description = description
    @amp = amp
  end

  def cd_player_on
    puts "#{@description} on"
  end

  def cd_player_off
    puts "#{@description} off"
  end

  def cd_player_eject
    puts "#{@description} eject"
  end

  def cd_player_play(title)
    @title = title
    @current_track = 0
    puts "#{@description} playing '#{title}'"
  end

  def cd_player_stop
    puts "#{@description} on"
  end

  def cd_player_pause
    puts "#{@description} on"
  end

  # def cd_player_on
  #   puts "#{@description} on"
  # end
end

class PopcornPopper
  def initialize(description)
    @description = description
  end

  def popcorn_popper_on
    puts "#{@description} on"
  end

  def popcorn_popper_off
    puts "#{@description} off"
  end

  def popcorn_popper_pop
    puts "#{@description} popping popcorn!"
  end
end

class Projector
  def initialize(description, dvd_player)
    @description = description
    @dvd_player = dvd_player
  end

  def projector_on
    puts "#{@description} on"
  end

  def projector_off
    puts "#{@description} off"
  end

  def wide_screen_mode
    puts "#{@description} in widescreen mode (16x9 aspect ratio)"
  end

  def tv_mode
    puts "#{@description} in tv mode (4x3 aspect ratio)"
  end
end

class Screen
  def initialize(description)
    @description = description
  end

  def screen_up
    puts "#{@description} going up"
  end

  def screen_down
    puts "#{@description} going down"
  end
end

class TheaterLights
  def initialize(description)
    @description = description
  end

  def theater_lights_on
    puts "#{@description} on"
  end

  def theater_lights_off
    puts "#{@description} off"
  end

  def theater_lights_dimm(level)
    puts "#{@description} dimming to #{level}"
  end
end

class Tuner
  def initialize(description, amp)
    @description = description
  end

  def tuner_on
    puts "#{@description} on"
  end

  def tuner_off
    puts "#{@description} off"
  end

  def setup_frequency(frequency)
    puts "#{@description} setting frequency to #{frequency}"
    @frequency = frequency
  end

  def setup_am
    puts "#{@description} setting AM mode"
  end

  def setup_fm
    puts "#{@description} setting FM mode"
  end
end

class HomeTheaterFacade
  def initialize(components)
    components.each do |name, component|
      instance_variable_set("@#{name}", component)
    end
  end

  def watch_movie(movie)
    puts "Get ready to watch a movie...\n"

    @popper.popcorn_popper_on
    @popper.popcorn_popper_pop
    @lights.theater_lights_dimm(10)
    @screen.screen_down
    @projector.projector_on
    @projector.wide_screen_mode
    @amp.amp_on
    @amp.setup_dvd(@dvd)
    @amp.setup_surround_sound
    @amp.setup_volume(5)
    @dvd.dvd_player_on
    @dvd.dvd_player_play(@movie)
  end

  def end_movie
    puts "Shutting movie theater down...\n"

    @popper.popcorn_popper_off
    @lights.theater_lights_on
    @screen.screen_up
    @projector.projector_off
    @amp.amp_off
    @dvd.dvd_player_stop
    @dvd.dvd_player_eject
    @dvd.dvd_player_off
  end

  def listen_to_cd(cd_title)
    puts "Get ready for an audiopile experence...\n"

    @lights.theater_lights_on
    @amp.amp_on
    @amp.setup_volume(5)
    @amp.setup_cd(cd)
    @amp.setup_stereo_sound
    @cd.cd_player_on
    @cd.cd_player_play(cd_title)
  end

  def end_cd
    puts "Shutting down CD...\n"

    @amp.amp_off
    @amp.setup_cd(cd)
    @cd.cd_player_eject
    @cd.cd_player_off
  end

  def listen_to_radio(frequency)
    puts "Tuning in the airwaves...\n"

    @tuner.tuner_on
    @tuner.setup_frequency(frequency)
    @amp.amp_on
    @amp.setup_volume(5)
    @amp.setup_tuner(tuner)
  end

  def end_radio
    puts "Shutting down the tuner...\n"

    @tuner.tuner_off
    @amp.amp_off
  end
end

class HomeTheaterTestDrive
  def initialize
    amp = Amplifier.new('Top-O-Line Amplifier')
    tuner = Tuner.new('Top-O-Line AM/FM Tuner', amp)
    dvd = DvdPlayer.new('Top-O-Line DVD Player', amp)
    cd = CdPlayer.new('Top-O-Line CD Player', amp)
    projector = Projector.new('Top-O-Line Projector', dvd)
    lights = TheaterLights.new('Theater Ceiling Lights')
    screen = Screen.new('Theater Screen')
    popper = PopcornPopper.new('Popcorn Popper')

    args = {
      amp: amp,
      tuner: tuner,
      dvd: dvd,
      cd: cd,
      projector: projector,
      lights: lights,
      screen: screen,
      popper: popper
    }
    home_theater = HomeTheaterFacade.new(args)
    home_theater.watch_movie('Riders of the Lost Ark')
    home_theater.end_movie
  end
end

HomeTheaterTestDrive.new