defmodule Tetrex.Tetromino do
  defstruct shape: :l, rotation: 0, location: {5, 1}

  def new(options \\ []) do
    __struct__(options)
  end

  def new_random do
    new(shape: random_shape())
  end

  defp random_shape do
    ~w[i t o l j z s]a
    |> Enum.random()
  end
end
