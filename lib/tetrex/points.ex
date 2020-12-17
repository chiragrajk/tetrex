defmodule Tetrex.Points do

  def move(points, {x, y}) do
    points
    |> Enum.map(fn {tx, ty} -> {tx + x, ty + y} end)
  end

end
