defmodule Aoc.Day01 do
  @moduledoc """
  Day 01.

  The Tyranny of the Rocket Equation.

  Part 1
    * Find the sum of the fuel requirements.
  """
  @day01 Path.join(["lib/day01/data.txt"])

  @doc """
  Read the input file.
  """
  def read do
    File.stream!(@day01, [], :line)
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.to_integer/1)
  end

  @doc """
  Function to calculate the mass.

  We will use this to map the entire data.
  """
  def calculate_fuel(mass) do
    mass
    |> Kernel./(3)
    |> floor()
    |> Kernel.-(2)
  end

  @doc """
  This will bind all of our functions together and calculate the fuel requirements.

   - Read the file
   - Calculate the fueld requirements per mass
   - Sum the updated data
  """
  def fuel_requirements do
    read()
    |> Stream.map(&calculate_fuel/1)
    |> Enum.sum()
  end
end
