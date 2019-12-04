defmodule Aoc.Day02 do
  @moduledoc """
  Day 02.

  1202 Program Alarm.

  Part 1
    * Restore the gravity assist program to the "1202" program alarm state.

  Notes:
  Input is a CSV string.
  Operations
    - 1 means addition
    - 2 means multiplication
    - 99 means program termination
  We will see data in chunks of 4.
    i.e. 1,0,0,0,99 -> 2,0,0,0,99 # 1 + 1 = 2
  """
  @day02 Path.join(["lib/day02/data.txt"])

  @doc """
  Read the input file.

  This time, it's just one long string, so we will want to parse accordingly.
  """
  def read do
    {:ok, data} = File.read(@day02)

    data
    |> String.trim()
    |> String.split(",")
    |> Stream.map(&String.to_integer/1)
  end

  @doc """
  We are going to store the state of the operation updates in a map.
  """
  def create_map(data) do
    data
    |> Stream.with_index()
    |> Stream.map(fn {val, key} -> {key, val} end)
    |> Enum.into(%{})
  end

  @doc """
  We will either add or multiply based off of the operation values.

  1 means addition
  2 means multiplication
  """
  def compute(:add, [x, y, index], state) do
    x = Map.get(state, x)
    y = Map.get(state, y)
    Map.put(state, index, x + y)
  end

  def compute(:multiply, [x, y, index], state) do
    x = Map.get(state, x)
    y = Map.get(state, y)
    Map.put(state, index, x * y)
  end

  @doc """
  Because operations will repeat every four, we will chunk the list every four.
  """
  def chunk_stream(data) do
    data
    |> Stream.chunk_every(4)
  end

  @doc """
  This is where we will update state based on the operation.

  We will pass in the chunked data and the state map.
  We will enumerate over each chunk and make respective operations with each chunk.
  We are using an `Enum.reduce_while` here to make sure we halt once we see 99.
  """
  def process(data, state) do
    data
    |> Enum.reduce_while(state, fn [op | params] = _chunk, state_acc ->
      case op do
        1 -> {:cont, compute(:add, params, state_acc)}
        2 -> {:cont, compute(:multiply, params, state_acc)}
        99 -> {:halt, state_acc}
      end
    end)
  end

  @doc """
  The runner function to bind things all together.
  """
  def run do
    file_stream = read()

    state =
      file_stream
      |> create_map()

    file_stream
    |> chunk_stream()
    |> process(state)
    |> Map.get(0)
  end
end
