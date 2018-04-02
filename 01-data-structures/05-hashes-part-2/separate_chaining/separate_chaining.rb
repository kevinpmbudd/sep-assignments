require_relative 'linked_list'

class SeparateChaining
  attr_reader :max_load_factor

  def initialize(size)
    @max_load_factor = 0.7
    @items = Array.new(size)
  end

  def []=(key, value)
    node = Node.new(key, value)
    hashed_key = index(key, size)

    if collision?(key)
      insert(@items, node, size)
    else
      @items[index(key, size)] = node
    end

    if load_factor > max_load_factor
      resize
    end
    print_hash
  end

  def [](key)
    hashed_key = index(key, size)

    if @items[hashed_key].class == Node
      @items[hashed_key].value
    else
      list = @items[hashed_key]
      list.find_by_key(key).value
    end
  end

  # Returns a unique, deterministically reproducible index into an array
  # We are hashing based on strings, let's use the ascii value of each string as
  # a starting point.
  def index(key, size)
    key.sum % size
  end

  # Calculate the current load factor
  def load_factor
    item_count / size.to_f
  end

  def item_count
    number_of_items = 0
    @items.compact.each do |item|
      if item.class == Node
        number_of_items += 1
      else
        node = item.head
        while node
          number_of_items += 1
          node = node.next
        end
      end
    end
    number_of_items
  end

  def size
    @items.length
  end

  # Resize the hash
  def resize
    doubled_array = Array.new(size * 2)
    @items.compact.each do |item|
      if item.class == LinkedList
        node = item.head
        while node
          insert(doubled_array, node, size * 2)
          node = node.next
        end
      else
        insert(doubled_array, item, size * 2)
      end
    end
    @items = doubled_array
  end

  def insert(array, node, size)
    if array[index(node.key, size)].class == Node && node.key != array[index(node.key, size)].key
      list = LinkedList.new
      old_head = array[index(node.key, size)]
      list.add_to_front(old_head)
      list.add_to_front(node)
      array[index(node.key, size)] = list
    elsif array[index(node.key, size)].class == LinkedList
      array[index(node.key, size)].add_to_front(node) unless array[index(node.key, size)].contains?(node)
    else
      array[index(node.key, size)] = node
    end
  end

  def collision?(key)
    hashed_key = index(key, size)
    @items[hashed_key]
  end

  def print_hash
    puts
    puts "==" * 30
    puts "Current Load Factor: #{load_factor}"
    puts "#{item_count} item(s) in #{size} 'buckets'"
    puts "~~" * 30
    puts
    @items.each_with_index do |item, index|
      if item.class == Node
        puts "bucket ##{index + 1}: #{item.key}: #{item.value}"
      elsif item.class == LinkedList
        puts "bucket ##{index + 1}:"
        node = item.head
        while node
          puts "          #{node.key}: #{node.value}"
          node = node.next
        end
      else
        puts "bucket ##{index + 1}: #{item.inspect}"
      end
    end
    puts
    puts "==" * 30
    puts
    puts
  end
end
