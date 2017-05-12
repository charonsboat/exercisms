defmodule RotationalCipher do
  @lower ?a..?z
  @upper ?A..?Z
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    to_charlist(text)
    |> Enum.map(fn(char) -> cycle(char, shift) end)
    |> to_string
  end

  defp cycle(char, shift) when char in @lower, do: cycle(char, shift, @lower)
  defp cycle(char, shift) when char in @upper, do: cycle(char, shift, @upper)
  defp cycle(char, _), do: char
  defp cycle(char, shift, chars) do
    rem(char - Enum.at(chars, 0) + shift, Enum.count(chars)) + Enum.at(chars, 0)
  end
end
