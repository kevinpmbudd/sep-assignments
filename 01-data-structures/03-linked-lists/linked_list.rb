require_relative 'node'

class LinkedList
  attr_accessor :head
  attr_accessor :tail

  # This method creates a new `Node` using `data`, and inserts it at the end of the list.
  def add_to_tail(node)
    if self.head == nil
      self.head = node
      self.tail = node
    else
      self.tail.next = node
      self.tail = node
    end
  end

  # This method removes the last node in the lists and must keep the rest of the list intact.
  def remove_tail
    node = self.head
    if node == self.tail
      self.head = nil
      self.tail = nil
    else
      while node && node.next
        if node.next == self.tail
          self.tail = node
          node.next = nil
        end
        node = node.next
      end
    end
  end

  # This method prints out a representation of the list.
  def print
    node = self.head
    while node
      puts node.data
      node = node.next
    end
  end

  # This method removes `node` from the list and must keep the rest of the list intact.
  def delete(node)
    if node == self.head
      remove_front
    elsif node == self.tail
      remove_tail
    else
      temp_node = self.head
      while temp_node && temp_node != node
        if temp_node.next == node
          temp_node.next = temp_node.next.next
        end
        temp_node = temp_node.next
      end
    end
  end

  # This method adds `node` to the front of the list and must set the list's head to `node`.
  def add_to_front(node)
    if self.head
      old_head = self.head
      self.head = node
      self.head.next = old_head
    else
      self.head = node
      self.tail = node
    end
  end

  # This method removes and returns the first node in the Linked List and must set Linked List's head to the second node.
  def remove_front
    if self.head.next
      self.head = self.head.next
    else
      self.head = nil
    end
  end

  def find(node)
    temp_node = self.head
    while temp_node && temp_node.data != node.data
      temp_node = temp_node.next
    end
    temp_node.data
  end
end
