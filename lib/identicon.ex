defmodule Identicon do
  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
  end

  def pick_color(image) do
    %Identicon.Image{hex: [r, g, b | _tail]} = image
    %Identicon.Image{ image | color: {r, g, b}}
  end

  def hash_input(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list
    %Identicon.Image{hex: hex}
  end

  def build_grid(%Identicon.Image{hex: hex_list} = image) do
    hex_list
    |> Enum.chunk_every(3, 3, :discard)
    |> Enum.map(&mirror_row/1)
  end

  def mirror_row([first, second | _tail] = row) do
    row ++ [second, first]
  end
end
