defmodule EulerTest do
  use ExUnit.Case
  doctest Euler

  defp generator(actor) do
  end

  test "fibonacci sequence generator" do
    {:ok, fib_actor} = Task.start_link(Euler, :fibonacci_actor, [1, 2])
    generator = fn -> send(fib_actor, {:get, self()})
                      receive do
                       {:next, next} -> next
                      end
                end
    first_seq = Euler.fib_seq(1, 2) |> Enum.take(1000)
    second_seq = Stream.repeatedly(generator) |> Enum.take(1000)
    assert first_seq  == second_seq
    Process.exit(fib_actor, :normal)
  end
end
