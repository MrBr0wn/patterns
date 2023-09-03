# frozen_string_literal: true

class Light
  def light_on
    puts 'Light is on'
  end

  def light_off
    puts 'Light is off'
  end
end

class GarageDoor
  def door_up
    puts 'Garage door is up'
  end

  def door_down
    puts 'Garage door is down'
  end

  def door_stop
    puts 'Garage door is up'
  end

  def light_on
    puts 'Garage light is on'
  end

  def light_off
    puts 'Garage light is off'
  end
end

class Command
  def execute
    raise NotImplementedError, "#{self.class} has not implemented '#{__method__}'"
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

class GarageDoorOpenCommand < Command
  def initialize(door)
    @door = door
  end

  def execute
    @door.door_up
  end
end

class SimpleRemoteControl
  def setup_command(command)
    @slot = command
  end

  def button_was_pressed
    @slot.execute
  end
end

class RemoteControlTest
  def initialize
    #light actions
    remote = SimpleRemoteControl.new
    light = Light.new
    light_on = LightOnCommand.new(light)

    remote.setup_command(light_on)
    remote.button_was_pressed

    # garage actions
    garage_door = GarageDoor.new
    garage_open = GarageDoorOpenCommand.new(garage_door)
    remote.setup_command(garage_open)
    remote.button_was_pressed
  end
end

RemoteControlTest.new
