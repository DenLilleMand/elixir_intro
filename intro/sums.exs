defmodule Sums do
    def of(0), do: 0
    def of(n) when n > 0, do: n + of(n-1)
    def gcd(x, 0), do: x
    def gcd(x, y), do: gcd(y, rem(x,y))
end