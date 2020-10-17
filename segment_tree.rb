class SegmentTree

  def initialize(array)
    @array = array
    @tree = Array.new(2*array.length + 1)
    build(1, 0, @array.length - 1)
  end

  def update_tree(idx, val)
    update(1, 0, @array.length - 1, idx, val)
  end

  def query_tree(l, r)
    query(1, 0, @array.length - 1, l, r)
  end

  private

  def build(node, start, final)
    if start == final
      @tree[node] = @array[start]
    else
      mid = (start + final) / 2
      build(2*node, start, mid)
      build(2*node+1, mid+1, final)
      @tree[node] = [@tree[2*node], @tree[2*node + 1]].min
    end
  end

  def update(node, start, final, idx, val)
    if start == final
      @array[start] = val
      @tree[node] = val
    else
      mid = (start + final) / 2
      if start <= idx && idx <= mid
        update(2*node, start, mid, idx, val)
      else
        update(2*node+1, mid + 1, final, idx, val)
      end
      @tree[node] = [@tree[2*node], @tree[2*node + 1]].min
    end
  end

  def query(node, start, final, l, r)
    return 999999999999999 if r < start || final < l
    return @tree[node] if l <= start && final <= r

    mid = (start + final) / 2
    q1 = query(node * 2, start, mid, l, r)
    q2 = query(node * 2 + 1, mid + 1, final, l, r)
    [q1, q2].min
  end

end

n, q = gets.chomp.split(' ').map(&:to_i)
arr = gets.chomp.split(' ').map(&:to_i)

solver = SegmentTree.new(arr)

q.times do
  op, x, y = gets.chomp.split(' ')
  x, y = [x, y].map(&:to_i)

  if op == 'q'
    puts solver.query_tree(x-1, y-1)
  else
    solver.update_tree(x-1, y-1)
  end
end
