require_relative 'data'

class Graph
  attr_accessor :actors

  def initialize(actors)
    @actors = actors
  end

  def find_kevin_bacon(start)
    start_node = actors[start]
    queue = []
    start_node.visited = true
    queue << start_node

    while !queue.empty?
      node = queue.shift
      node.film_actor_hash.each do |key, value|
        value.each do |actor|
          actor_node = actors[actor]
          if actor_node == Kevin_Bacon
            actor_node.predecessor = node
            actor_node.edge_to_source = key
            return build_edges_array(actor_node)
          else
            if actor_node.visited == false
              actor_node.edge_to_source = key
              actor_node.predecessor = node
              actor_node.visited = true
              queue << actor_node
            end
          end
        end
      end
    end
  end

  private

  def build_edges_array(actor)
    edges = []
    while actor.predecessor
      edges << actor.edge_to_source
      actor = actor.predecessor
    end
    edges.reverse
  end
end
