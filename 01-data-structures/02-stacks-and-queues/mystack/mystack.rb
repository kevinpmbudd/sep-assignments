class MyStack
  attr_accessor :top

  def initialize
    @stack = Array.new
    self.top = nil
  end

  def push(item)
    if self.empty?
      @stack[0] = item
    else
      @stack[@stack.length] = item
    end
    self.top = item
  end

  def pop
    unless self.empty?
      item = @stack.delete_at(@stack.length - 1)
      self.top = @stack.last
    end
    item
  end

  def empty?
    @stack.length == 0
  end

  def count
    @stack.length
  end
end
