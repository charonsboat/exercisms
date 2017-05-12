defmodule SecretHandshake do
  use Bitwise
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    []
    |> command(code, 0b1000, "jump")
    |> command(code, 0b100, "close your eyes")
    |> command(code, 0b10, "double blink")
    |> command(code, 0b1, "wink")
    |> command(code, 0b10000, &Enum.reverse/1)
  end

  defp command(list, code, comparator, action) do
    command(list, ((code &&& comparator) > 0), action)
  end

  defp command(list, false, _), do: list
  defp command(list, true, action) when is_binary(action), do: [action | list]
  defp command(list, true, func), do: func.(list)
end
