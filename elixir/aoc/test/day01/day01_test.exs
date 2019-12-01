defmodule Aoc.Day01Test do
  use ExUnit.Case
  alias Aoc.Day01

  test "calculates fuel" do
    assert Day01.calculate_fuel(12) == 2
    assert Day01.calculate_fuel(14) == 2
    assert Day01.calculate_fuel(1_969) == 654
    assert Day01.calculate_fuel(100_756) == 33_583
  end
end
