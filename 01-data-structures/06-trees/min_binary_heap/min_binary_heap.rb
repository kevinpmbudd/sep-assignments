require_relative 'node'

class MinBinaryHeap
  attr_accessor :heap

  def initialize
    @heap = []
  end

  def insert(node)
    index = heap.length
    heap[index] = node
    swim(index) if has_parent?(node)
  end

  def find(data)
    return nil if data.nil?

    heap.each do |item|
      return item if item.title == data
    end
  end

  def find_index(node)
    heap.index(node)
  end

  def root
    heap[0] unless heap.empty?
  end

  def delete(data)
    return nil if data.nil?

    if data == heap.last.title
      heap.pop
    else
      node = find(data)
      index = find_index(node)
      last_node = heap[heap.length - 1]
      heap[index] = last_node
      heap.pop
      if left_child(heap[index])
        sink(index)
      end
    end
  end

  def printf
    heap.each { |item| puts "#{item.title}: #{item.rating}" }
  end

  def swim(index)
    parent_index = (index / 2).floor
    if parent_larger?(index)
      temp_node = heap[parent_index]
      heap[parent_index] = heap[index]
      heap[index] = temp_node
      swim(parent_index)
    end
  end

  def sink(index)
    smallest_child_index = smallest_child(index)
    temp_node = heap[smallest_child_index]
    heap[smallest_child_index] = heap[index]
    heap[index] = temp_node
    if left_child(heap[smallest_child_index])
      sink(smallest_child_index)
    end
  end

  def has_parent?(node)
    find_index(node) > 0
  end

  def parent_larger?(index)
    heap[(index / 2).floor] && heap[(index / 2).floor].rating > heap[index].rating
  end

  def left_child(node)
    index = find_index(node)
    heap[index * 2 + 1]
  end

  def right_child(node)
    index = find_index(node)
    heap[index * 2 + 2]
  end

  def smallest_child(index)
    if left_child(heap[index]) && right_child(heap[index])
      left_child(heap[index]).rating < right_child(heap[index]).rating ? find_index(left_child(heap[index])) : find_index(right_child(heap[index]))
    else
      find_index(left_child(heap[index]))
    end
  end
end
