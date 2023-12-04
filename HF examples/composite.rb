# frozen_string_literal: true

class MenuComponent
end

class MenuItem < MenuComponent
  attr_reader :name, :description, :vegetarian, :price

  def initialize(name, description, vegetarian, price)
    @name = name
    @description = description
    @vegetarian = vegetarian
    @price = price
  end

  def print
    $stdout.print "  #{@name}"
    $stdout.print '(v)' if vegetarian
    $stdout.print ", #{@price}  -- #{@description}"
  end
end

class Menu < MenuComponent
  def initialize(name, description)
    @menu_components = []
    @name = name
    @description = description
  end

  def add(menu_component)
    @menu_components << menu_component
  end

  def remove(menu_component)
    @menu_components.delete(menu_component)
  end

  def get_child(index)
    @menu_components[index]
  end

  def name
    @name
  end

  def description
    @description
  end

  def print
    puts "\n#{@name}, #{@description}"
    puts '----------------------------'

    @menu_components.each(&:print)
  end
end

class Waitress
  def initialize(all_menus)
    @all_menus = all_menus
  end

  def print_menu
    @all_menus.print
  end
end

class MenuTestDrive
  def initialize
    @pancake_house_menu = Menu.new('PANCAKE HOUSE MENU', 'Breakfast')
    @dinner_menu = Menu.new('DINER MENU', 'Lunch')
    @cafe_menu = Menu.new('CAFE MENU', 'Dinner')
    @dessert_menu = Menu.new('DESSERT MENU', 'Dessert of course!')

    @all_menus = Menu.new('ALL MENUS', 'All menus combined')

    @all_menus.add(@pancake_house_menu)
    @all_menus.add(@dinner_menu)
    @all_menus.add(@cafe_menu)

    @dinner_menu.add(
      MenuItem.new(
        'Pasta',
        'Spaghetti with Marinara Sauce, and a slice of sourdough bread',
        true,
        3.89
      )
    )

    @dinner_menu.add(@dessert_menu)

    @dessert_menu.add(
      MenuItem.new(
        'Apple Pie',
        'Apple pie with a flakey crust, topped with vanilla icecream',
        true,
        1.59
      )
    )

    waitress = Waitress.new(@all_menus)
    waitress.print_menu
  end
end

MenuTestDrive.new
