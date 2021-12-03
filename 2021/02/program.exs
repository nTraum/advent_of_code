defmodule AdventOfCode.Y2021.D02 do
  @moduledoc "Solves https://adventofcode.com/2021/day/2 part one & two."

  def solve_part_one() do
    %{horizontal: horizontal, depth: depth} =
      read_directions_from_file()
      |> parse_directions()
      |> follow_directions()

    horizontal * depth
  end

  def solve_part_two() do
    %{horizontal: horizontal, depth: depth} =
      read_directions_from_file()
      |> parse_directions()
      |> follow_directions_with_aim()

    horizontal * depth
  end

  defp read_directions_from_file() do
    __ENV__.file
    |> Path.dirname()
    |> Path.join("input.txt")
    |> File.stream!()
    |> Stream.map(&String.trim/1)
  end

  defp parse_directions(lines) do
    Stream.map(lines, &parse_direction/1)
  end

  defp parse_direction(line) do
    with [direction, value] <- String.split(line) do
      {String.to_atom(direction), String.to_integer(value)}
    end
  end

  defp follow_directions(directions) do
    position = %{horizontal: 0, depth: 0}

    Enum.reduce(directions, position, fn direction, position ->
      case direction do
        {:forward, value} -> Map.update!(position, :horizontal, &(&1 + value))
        {:up, value} -> Map.update!(position, :depth, &(&1 - value))
        {:down, value} -> Map.update!(position, :depth, &(&1 + value))
      end
    end)
  end

  defp follow_directions_with_aim(directions) do
    position = %{horizontal: 0, depth: 0, aim: 0}

    Enum.reduce(directions, position, fn direction, position ->
      case direction do
        {:forward, value} ->
          Map.update!(position, :horizontal, &(&1 + value))
          Map.update!(position, :depth, &(&1 + position[:aim] * value))

        {:up, value} ->
          Map.update!(position, :aim, &(&1 - value))

        {:down, value} ->
          Map.update!(position, :aim, &(&1 + value))
      end
    end)
  end
end

IO.puts("Part one: #{AdventOfCode.Y2021.D02.solve_part_one()}")
IO.puts("Part two: #{AdventOfCode.Y2021.D02.solve_part_two()}")
