# frozen_string_literal: true

class Command
  def execute
    raise NotImplementedError, "#{self.class} has not implemented '#{__method__}'"
  end
end

class NoCommand < Command
  def execute
    raise NotImplementedError, "#{self.class} has not implemented '#{__method__}'"
  end
end

class Light
  def initialize(location)
    @location = location
  end

  def light_on
    puts "#{@location} light is on"
  end

  def light_off
    puts "#{@location} light is off"
  end
end

class CeilingFan
  HIGHT = 2
  MEDIUM = 1
  LOW = 0

  def initialize(location)
    @location = location
    @level = nil
  end

  def high
    @level = HIGHT
    puts "#{@location} ceiling fan is on high"
  end

  def medium
    @level = MEDIUM
    puts "#{@location} ceiling fan is on medium"
  end

  def low
    @level = LOW
    puts "#{@location} ceiling fan is on LOW"
  end

  def ceiling_off
    @level = 0
    puts "#{@location} ceiling fan is off"
  end

  def speed
    @level
  end
end

class GarageDoor
  def initialize(location = '')
    @location = location
  end

  def door_up
    puts "#{@location} garage Door is Up"
  end

  def door_down
    puts "#{@location} garage Door is Down"
  end

  def door_stop
    puts "#{@location} garage Door is Stopped"
  end

  def light_on
    puts "#{@location} garage light is on"
  end

  def light_off
    puts "#{@location} garage light is off"
  end
end

class Stereo
  def initialize(location)
    @location = location
  end

  def stereo_on
    puts "#{@location} stereo is on"
  end

  def stereo_off
    puts "#{@location} stereo is off"
  end

  def setup_cd
    puts "#{@location} stereo is set for CD input"
  end

  def setup_dvd
    puts "#{@location} stereo is set for DVD input"
  end

  def setup_radio
    puts "#{@location} stereo is set for Radio"
  end

  def setup_volume(volume)
    puts "#{@location} Stereo volume set to #{volume}"
  end
end

class LightOffCommand < Command
  def initialize(light)
    @light = light
  end

  def execute
    @light.light_off
  end
end

class LightOnCommand < Command
  def initialize(light)
    @light = light
  end

  def execute
    @light.light_on
  end
end

class CeilingFanOnCommand < Command
  def initialize(ceiling_fan)
    @ceiling_fan = ceiling_fan
  end

  def execute
    @ceiling_fan.high
  end
end

class CeilingFanOffCommand < Command
  def initialize(ceiling_fan)
    @ceiling_fan = ceiling_fan
  end

  def execute
    @ceiling_fan.ceiling_off
  end
end

class GarageDoorUpCommand < Command
  def initialize(garage_door)
    @garage_door = garage_door
  end

  def execute
    @garage_door.door_up
  end
end

class GarageDoorDownCommand < Command
  def initialize(garage_door)
    @garage_door = garage_door
  end

  def execute
    @garage_door.door_down
  end
end

class StereoOnWithCDCommand < Command
  def initialize(stereo)
    @stereo = stereo
  end

  def execute
    @stereo.stereo_on
    @stereo.setup_cd
    @stereo.setup_volume(11)
  end
end

class StereoOffCommand < Command
  def initialize(stereo)
    @stereo = stereo
  end

  def execute
    @stereo.stereo_off
  end
end

class RemoteControl
  attr_accessor :on_commands, :off_commands

  def initialize
    @on_commands = []
    @off_commands = []
    no_command = NoCommand.new
    7.times do |i|
      @on_commands[i] = no_command
      @off_commands[i] = no_command
    end
  end

  def setup_command(slot, on_command, off_command)
    @on_commands[slot] = on_command
    @off_commands[slot] = off_command
  end

  def on_button_was_pushed(slot)
    @on_commands[slot].execute
  end

  def off_button_was_pushed(slot)
    @off_commands[slot].execute
  end

  def display
    puts "\n----- Remote Control -----\n"
    @on_commands.count.times do |i|
      puts "[slot #{i}] #{@on_commands[i].class}\t\t#{@off_commands[i].class}\n"
    end
    puts "\n"
  end
end

class RemoteLoader
  def initialize
    remote_control = RemoteControl.new
    living_room_light = Light.new('Living Room')
    kitchen_light = Light.new('Kitchen')
    ceiling_fan = CeilingFan.new('Living Room')
    garage_door = GarageDoor.new
    stereo = Stereo.new('Living Room')

    living_room_light_on = LightOnCommand.new(living_room_light)
    living_room_light_off = LightOffCommand.new(living_room_light)
    kitchen_light_on = LightOnCommand.new(kitchen_light)
    kitchen_light_off = LightOnCommand.new(kitchen_light)

    ceiling_fan_on = CeilingFanOnCommand.new(ceiling_fan)
    ceiling_fan_off = CeilingFanOffCommand.new(ceiling_fan)

    garage_door_up = GarageDoorUpCommand.new(garage_door)
    garage_door_down = GarageDoorDownCommand.new(garage_door)

    stereo_on_with_cd = StereoOnWithCDCommand.new(stereo)
    stereo_off = StereoOffCommand.new(stereo)

    remote_control.setup_command(0, living_room_light_on, living_room_light_off)
    remote_control.setup_command(1, kitchen_light_on, kitchen_light_off)
    remote_control.setup_command(2, ceiling_fan_on, ceiling_fan_off)
    remote_control.setup_command(3, stereo_on_with_cd, stereo_off)

    remote_control.display

    remote_control.on_button_was_pushed(0)
    remote_control.off_button_was_pushed(0)
    remote_control.on_button_was_pushed(1)
    remote_control.off_button_was_pushed(1)
    remote_control.on_button_was_pushed(2)
    remote_control.off_button_was_pushed(2)
    remote_control.on_button_was_pushed(3)
    remote_control.off_button_was_pushed(3)
  end
end

RemoteLoader.new