class Node
  attr_accessor :name, :film_actor_hash, :edge_to_source, :predecessor, :visited

  def initialize(name, film_actor_hash={}, edge_to_source=nil, predecessor=nil, visited=false)
    @name = name
    @film_actor_hash = film_actor_hash
    @edge_to_source = edge_to_source
    @predecessor = predecessor
    @visited = visited
  end
end
