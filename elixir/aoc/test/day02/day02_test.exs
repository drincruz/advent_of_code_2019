defmodule Aoc.Day02Test do
  use ExUnit.Case
  alias Aoc.Day02

  test "adds state operations properly" do
    file_stream = [1, 0, 0, 0, 99]
    state = Day02.create_map(file_stream)

    data =
      file_stream
      |> Day02.chunk_stream()

    assert Day02.process(data, state) == %{0 => 2, 1 => 0, 2 => 0, 3 => 0, 4 => 99}
  end

  test "multiplies state operations properly" do
    file_stream = [2, 3, 0, 3, 99]
    state = Day02.create_map(file_stream)

    data =
      file_stream
      |> Day02.chunk_stream()

    assert Day02.process(data, state) == %{0 => 2, 1 => 3, 2 => 0, 3 => 6, 4 => 99}
  end
end
