require_relative 'hash_item'

class HashClass

  def initialize(size)
    @items = Array.new(size)
  end

  def []=(key, value)
    item = HashItem.new(key,value)

    if collision?(key) && (@items[index(key, size)].value != value)
      resize
      insert(@items, item, size)
    else
      @items[index(key, size)] = item
    end
    puts "Size of Hash: #{size}"
    puts @items.compact
  end

  def [](key)
    if @items[index(key, size)].class == HashItem
      @items[index(key, size)].value
    else
      items = @items[index(key, size)]
      items.each do |item|
        if item.key == key
          return item.value
        end
      end
    end
  end

  def resize
    new_array = Array.new(size * 2)
    @items.compact.each do |item|
      if item.class == Array
        item.each do |i|
          insert(new_array, i, size * 2)
        end
      else
        insert(new_array, item, size * 2)
      end
    end
    @items = new_array
  end

  def insert(array, item, size)
    if array[index(item.key, size)].class == HashItem
      items_array = Array.new
      items_array << array[index(item.key, size)] << item
      array[index(item.key, size)] = items_array
    elsif array[index(item.key, size)].class == Array
      array[index(item.key, size)] << item
    else
      array[index(item.key, size)] = item
    end
  end

  # Returns a unique, deterministically reproducible index into an array
  # We are hashing based on strings, let's use the ascii value of each string as
  # a starting point.
  def index(key, size)
    key.sum % size
  end

  # Simple method to return the number of items in the hash
  def size
    @items.count
  end

  def collision?(key)
    @items[index(key, size)]
  end
end
