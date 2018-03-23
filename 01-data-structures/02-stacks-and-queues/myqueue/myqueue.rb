class MyQueue
  attr_accessor :head
  attr_accessor :tail

  def initialize
    @queue = Array.new
    @head = @queue[0]
  end

  def enqueue(element)
    if self.empty?
      @queue[0] = element
    else
      @queue[@queue.length] = element
    end
    update_head_tail
  end

  def dequeue
    unless self.empty?
      item = @queue.delete_at(0)
      update_head_tail
    end
    item
  end

  def empty?
    @queue.length == 0
  end

  def update_head_tail
    @head = @queue[0]
    @tail = @queue[@queue.length - 1]
  end
end
