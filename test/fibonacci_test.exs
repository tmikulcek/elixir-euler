defmodule FibonacciTest do
  use ExUnit.Case
  doctest Fibonacci

  test "fibonacci sequence generator" do
    {:ok, fib_actor} = Task.start_link(Fibonacci, :fibonacci_actor, [1, 2])
    generator = fn -> send(fib_actor, {:get, self()})
                      receive do
                       {:next, next} -> next
                      end
                end
    first_seq = Fibonacci.fib_seq(1, 2) |> Enum.take(1000)
    second_seq = Stream.repeatedly(generator) |> Enum.take(1000)
    assert first_seq  == second_seq
    Process.exit(fib_actor, :normal)
  end
end
