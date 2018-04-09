require_relative 'node'

class BinarySearchTree
  def initialize(root)
    @root = root
    @queue = []
  end

  def insert(root, node)
    if root.rating >= node.rating
      if root.left.nil?
        node.parent = root
        root.left = node
      else
        insert(root.left, node)
      end
    else
      if root.right.nil?
        node.parent = root
        root.right = node
      else
        insert(root.right, node)
      end
    end
  end

  # Recursive Depth First Search
  def find(root, data)
    if data.nil?
      return nil
    elsif root.title == data
      return root
    else
      left = find(root.left, data) if root.left
      right = find(root.right, data) if root.right
      left or right
    end
  end

  def delete(root, data)
    return nil if data == nil
    node = find(root, data)
    parent = node.parent

    if !node.nil?
      remove(node, parent)
    end
  end

  def remove(node, parent)
    if node.left.nil? && node.right.nil?
      parent.left = nil if parent.left == node
      parent.right = nil if parent.right == node
    elsif !node.left.nil? && node.right.nil?
      parent.left = node.left if parent.left == node
      parent.right = node.left if parent.right == node
    elsif node.left.nil? && !node.right.nil?
      parent.left = node.right if parent.left == node
      parent.right = node.right if parent.right == node
    else
      replacement_node = min(node)
      node.title = replacement_node.title
      node.rating = replacement_node.rating
      remove(replacement_node, replacement_node.parent)
    end
  end

  def min(root)
    node = root.right
    while node.left
      node = node.left
    end
    node
  end

  # Recursive Breadth First Search
  def printf(children=nil)
    if @queue.length == 0
      @queue.push(@root)
      arr = Array.new
      arr << @root.left if @root.left
      arr << @root.right if @root.right
      printf arr
    else
      arr = Array.new
      children.each do |child|
        @queue << child
        arr << child.left if child.left
        arr << child.right if child.right
      end
      printf arr if arr.length != 0
    end

    if children == nil
      @queue.each do |item|
        puts "#{item.title}: #{item.rating}"
      end
      @queue = []
    end
  end
end
