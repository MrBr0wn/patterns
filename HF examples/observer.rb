# frozen_string_literal: true

class Subject
  def register_observer(observer)
    raise NotImplementedError, "#{self.class} has not implemented '#{__method__}'"
  end

  def remove_observer
    raise NotImplementedError, "#{self.class} has not implemented '#{__method__}'"
  end

  def notify_observers
    raise NotImplementedError, "#{self.class} has not implemented '#{__method__}'"
  end
end

class Observer
  def update(temp, humidity, pressure)
    raise NotImplementedError, "#{self.class} has not implemented '#{__method__}'"
  end
end

class DisplayElement
  def display_message
    raise NotImplementedError, "#{self.class} has not implemented '#{__method__}'"
  end
end

class WeatherData < Subject
  attr_reader :temp, :humidity, :pressure

  def initialize
    @observers = []
  end

  def register_observer(observer)
    @observers << observer
  end

  def remove_observer(observer)
    @observers.delete(observer)
  end

  def notify_observers
    @observers.each do |observer|
      observer.update(temp, humidity, pressure)
    end
  end

  def measurements_changed
    notify_observers
  end

  def set_measurements(temp, humidity, pressure)
    @temp = temp if temp
    @humidity = humidity if humidity
    @pressure = pressure if pressure
    measurements_changed if temp || pressure || humidity
  end
end

class CurrentConditionsDisplay < DisplayElement
  attr_reader :temp, :humidity, :pressure

  def initialize(weather_data)
    @weather_data = weather_data
    weather_data.register_observer(self)
  end

  def update(temp, humidity, pressure)
    @temp = temp
    @humidity = humidity
    display_message
  end

  def display_message
    puts "Current conditions: #{temp}F degrees and #{humidity}% humidity"
  end
end

class WeatherStation
  weather_data = WeatherData.new
  current_display = CurrentConditionsDisplay.new(weather_data)

  # statistics_display = StatisticsDisplay.new(weather_data)
  # forecast_display = ForecastDisplay(weather_data)

  weather_data.set_measurements(80, 65, 30.4)
  weather_data.set_measurements(82, 70, 29.2)
  weather_data.set_measurements(78, 90, 29.2)
end

WeatherStation.new
