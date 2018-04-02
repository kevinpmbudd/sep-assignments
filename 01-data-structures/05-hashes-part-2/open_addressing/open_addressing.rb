require_relative 'node'

class Node
  attr_accessor :next
  attr_accessor :key
  attr_accessor :value

  def initialize(key, value)
    @key = key
    @value = value
  end
end

class OpenAddressing
  def initialize(size)
    @items = Array.new(size)
  end

  def []=(key, value)
    node = Node.new(key, value)
    insert(@items, node, size)
    print_hash
  end

  def [](key)
    if key == @items[index(key, size)].key
      @items[index(key, size)].value
    else
      if index(key, size) < size - 1
        new_index = index(key, size) + 1
      else
        new_index = 0
      end
      while @items[new_index].key != key
        if new_index < size - 1
          new_index += 1
        else
          new_index = 0
        end
      end
      @items[new_index].value
    end
  end

  # Returns a unique, deterministically reproducible index into an array
  # We are hashing based on strings, let's use the ascii value of each string as
  # a starting point.
  def index(key, size)
    key.sum % size
  end

  # Given an index, find the next open index in @items
  def next_open_index(index)
    return -1 unless @items.include?(nil)
    if index < size - 1
      new_index = index + 1
    else
      new_index = 0
    end
    while @items[new_index]
      if new_index < size - 1
        new_index += 1
      else
        new_index = 0
      end
    end
    new_index
  end

  # Simple method to return the number of items in the hash
  def size
    @items.count
  end

  # Resize the hash
  def resize
    doubled_array = Array.new(size * 2)
    @items.compact.each do |item|
      insert(doubled_array, item, size * 2)
    end
    @items = doubled_array
  end

  def insert(array, node, size)
    hashed_key = index(node.key, size)
    if array[hashed_key] == nil
      array[hashed_key] = node
    else
      new_index = next_open_index(hashed_key)
      if new_index == -1
        resize
        insert(@items, node, size)
      else
        array[new_index] = node
      end
    end
  end

  def print_hash
    puts
    puts "==" * 30
    puts
    @items.each_with_index do |item, index|
      if item.class == Node
        puts "items[#{index}] #{item.key}: #{item.value}"
      else
        puts "items[#{index}] #{item.inspect}"
      end
    end
    puts
    puts "==" * 30
    puts
  end
end
