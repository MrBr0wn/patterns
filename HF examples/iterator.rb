# frozen_string_literal: true

class Iterator
  def has_next?
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def next
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end

class PancakeHouseMenuIterator < Iterator
  def initialize(items)
    @items = items
    @position = 0
  end

  def has_next?
    if @position >= @items.size || @items[@position].nil?
      false
    else
      true
    end
  end

  def next
    menu_item = @items[@position]
    @position += 1
    menu_item
  end
end

class CafeMenuIterator < Iterator
  def initialize(items)
    @items = items
    @position = 0
  end

  def has_next?
    if @position >= @items.size || @items[@position].nil?
      false
    else
      true
    end
  end

  def next
    menu_item = @items[@position]
    @position += 1
    menu_item
  end
end

class MenuItem
  attr_reader :name, :description, :vegetarian, :price

  def initialize(name, description, vegetarian, price)
    @name = name
    @description = description
    @vegetarian = vegetarian
    @price = price
  end
end

class CafeMenu
  def initialize
    @menu_items = {}
    add_item(
      'Veggie Burger and Air Fries',
      'Veggie burger on a whole wheat bun, lettuce, tomato, and fries',
      true,
      3.99
    )
    add_item(
      'Soup of the day',
      'A cup of the soup of the day, with a side salad',
      false,
      3.69
    )
    add_item(
      'Burrito',
      'A large burrito, with whole pinto beans, salsa, guacamole',
      true,
      4.29
    )
  end

  def add_item(name, description, vegetarian, price)
    menu_item = MenuItem.new(name, description, vegetarian, price)
    @menu_items[name] = menu_item
  end

  def create_iterator
    CafeMenuIterator.new(@menu_items.values)
  end
end

class PancakeHouseMenu
  def initialize
    @menu_items = []
    add_item('K&B\'s Pancake Breakfast',
             'Pancakes with scrambled eggs, and toast',
             true,
             2.99)
    add_item('Regular Pancake Breakfast',
             'Pancakes with fried eggs, sausage',
             false,
             2.99)
    add_item('Blueberry Pancakes',
             'Pancakes made with fresh blueberries',
             true,
             3.49)
    add_item('Waffles',
             'Waffles, with your choice of blueberries or strawberries',
             true,
             3.59)
  end

  def add_item(name, description, vegetarian, price)
    @menu_items << [name, description, vegetarian, price]
  end

  def create_iterator
    PancakeHouseMenuIterator.new(@menu_items)
  end
end

class Waitress
  def initialize(pancake_house_menu, another_menu=nil)
    @pancake_house_menu = pancake_house_menu
    @another_menu = another_menu
  end

  def print_menu
    pancake_iterator = @pancake_house_menu.create_iterator
    another_iterator = @another_menu.create_iterator if @another_menu
    puts "MENU\n----\nBREAKFAST"
    print_menu_private(pancake_iterator)
    if @another_menu
      puts "\nANOTHER MENU"
      print_menu_private(another_iterator)
    end
  end

  private

  def print_menu_private(iterator)
    while iterator.has_next?
      menu_item = iterator.next
      p iterator.class
      if iterator.is_a?(CafeMenuIterator)
        puts "#{menu_item.name}, #{menu_item.price} -- #{menu_item.description}"
      else
        puts "#{menu_item[0]}, #{menu_item[3]} -- #{menu_item[1]}"
      end
    end
  end
end

class MenuTestDrive
  pancake_house_menu = PancakeHouseMenu.new
  another_menu = CafeMenu.new

  waitress = Waitress.new(pancake_house_menu, another_menu)
  waitress.print_menu
end
