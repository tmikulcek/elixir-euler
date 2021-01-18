defmodule ReversePolish do

  @doc """
  Accepts a mathematical expression in reverse-polish notation and solves it.

  ## Examples

  iex> ReversePolish.solve("1 1 +")
  2

  iex> ReversePolish.solve("1 2 3 * +")
  7
  """
  def solve(valueString) do
    tokens = valueString
             |> String.split(" ")
             |> Enum.map(&tokenize/1)
             |> Enum.reject(&is_nil/1)
    solve([], tokens)
  end

  defp solve([], []), do: nil
  defp solve([result | []], []), do: result
  defp solve(accumulator, [head | tokens]) when is_number(head), do: solve([head | accumulator], tokens)

  #  Solve using single function per operator
#  defp solve([second, first | acc], [:+ | tokens]), do: solve([first + second | acc], tokens)
#  defp solve([second, first | acc], [:- | tokens]), do: solve([first - second | acc], tokens)
#  defp solve([second, first | acc], [:* | tokens]), do: solve([first * second | acc], tokens)
#  defp solve([second, first | acc], [:/ | tokens]), do: solve([first / second | acc], tokens)

  #  Solve using case matching on operator
#  defp solve([second, first | acc], [operator | tokens]) do
#    result = case operator do
#      :+ -> first + second
#      :- -> first - second
#      :* -> first * second
#      :/ -> first / second
#    end
#    solve([result | acc], tokens)
#  end

  #  Solve by calling eval on operator
  defp solve([second, first | acc], [operator | tokens]) do
    {result, _} = Code.eval_quoted({operator, [], [first, second]})
    solve([result | acc], tokens)
  end

  defp tokenize(inputChar) do
    case Integer.parse(inputChar) do
      :error -> tokenize_operator(inputChar)
      {number, _} -> number
    end
  end

  defp tokenize_operator(inputChar) do
    case inputChar do
      "+" -> :+
      "-" -> :-
      "*" -> :*
      "/" -> :/
      _ -> nil
    end
  end
end
