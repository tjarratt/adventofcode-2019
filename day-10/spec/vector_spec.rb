require 'vector'

describe Vector do
  it 'should sort correctly' do
    v1 = Vector.new(0, 1)
    v2 = Vector.new(1, 2)
    v3 = Vector.new(1, 1)
    v4 = Vector.new(2, 1)
    v5 = Vector.new(1, 0)

    unsorted = [v5, v4, v3, v2, v1]
    expect(unsorted.sort).to eq [v1, v2, v3, v4, v5]
  end

  it 'should sort all of the quadrants correctly' do
    v1 = Vector.new(0, 1)
    v2 = Vector.new(1, 2)
    v3 = Vector.new(1, 1)
    v4 = Vector.new(2, 1)
    v5 = Vector.new(1, 0)
    v6 = Vector.new(2, -1)
    v7 = Vector.new(1, -1)
    v8 = Vector.new(1, -2)
    v9 = Vector.new(0, -1)
    v10 = Vector.new(-1, -2)
    v11 = Vector.new(-1, -1)
    v12 = Vector.new(-2, -1)
    v13 = Vector.new(-1, 0)
    v14 = Vector.new(-2, 1)
    v15 = Vector.new(-1, 1)
    v16 = Vector.new(-1, 2)

    unsorted = [v16, v15, v14, v13, v12, v11, v10, v9, v8, v7, v6, v5, v4, v3, v2, v1]
    sorted = unsorted.sort

    expect(sorted).to eq [
      v1, v2, v3, v4, v5, v6, v7, v8,
      v9, v10, v11, v12, v13, v14, v15, v16
    ]
  end
end
