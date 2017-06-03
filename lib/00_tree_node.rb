require 'byebug'
class PolyTreeNode

  attr_reader :parent, :children, :value

  def initialize(value, parent = nil, children = [])
    @value = value
    @parent = parent
    @children = children
  end

  # def parent
  #   @parent
  # end
  #
  # def children
  #   @children
  # end
  #
  # def value
  #   @value
  # end

  def parent=(parent_node)
    unless @parent == nil
      @parent.children.delete(self)
      @parent = nil
    end
    @parent = parent_node
    unless parent_node == nil
      parent_node.children << self #can't invoke children method on nil
    end
  end

  def add_child(child_node)
    child_node.parent = (self)
  end

  def remove_child(child_node)
    unless self.children.include?(child_node)
      raise "Invalid child."
    end
    child_node.parent = nil
  end

  def dfs(target)
    return self if self.value == target
    self.children.each do |child|
      result = child.dfs(target)
      return result if result
    end
    nil
  end

  def bfs(target)
    queue = [self]
    until queue.empty?
      current_node = queue.shift
      return current_node if current_node.value == target
      queue.concat(current_node.children)
    end
    nil
  end
end

a = PolyTreeNode.new('root')
b = PolyTreeNode.new('child1')
c = PolyTreeNode.new('child2')
d = PolyTreeNode.new('child3')
e = PolyTreeNode.new('child4')

b.parent = a
c.parent = a
d.parent = a
e.parent = b
