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

class HeatIndexDisplay < DisplayElement
  attr_reader :heat_index

  def initialize(weather_data)
    @weather_data = weather_data
    weather_data.register_observer(self)
  end

  def update(temp, rh, pressure)
    @heat_index = compute_heat_index(temp, rh)
    display_message
  end

  def compute_heat_index(t, rh)
    ((16.923 + (0.185212 * t) + (5.37941 * rh) - (0.100254 * t * rh) +
    (0.00941695 * (t * t)) + (0.00728898 * (rh * rh)) +
    (0.000345372 * (t * t * rh)) - (0.000814971 * (t * rh * rh)) +
    (0.0000102102 * (t * t * rh * rh)) - (0.000038646 * (t * t * t)) + (0.0000291583 *
      (rh * rh * rh)) + (0.00000142721 * (t * t * t * rh)) +
      (0.000000197483 * (t * rh * rh * rh)) - (0.0000000218429 * (t * t * t * rh * rh)) +
      0.000000000843296 * (t * t * rh * rh * rh)) -
      (0.0000000000481975 * (t * t * t * rh * rh * rh)))
  end

  def display_message
    puts "Heat index is: #{heat_index}\n\n"
  end
end

class WeatherStation
  weather_data = WeatherData.new
  CurrentConditionsDisplay.new(weather_data)
  HeatIndexDisplay.new(weather_data)

  # statistics_display = StatisticsDisplay.new(weather_data)
  # forecast_display = ForecastDisplay(weather_data)

  weather_data.set_measurements(80, 65, 30.4)
  weather_data.set_measurements(82, 70, 29.2)
  weather_data.set_measurements(78, 90, 29.2)
end

WeatherStation.new
