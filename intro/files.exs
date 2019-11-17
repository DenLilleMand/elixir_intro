defmodule SomeFiles do
    def suffix(filename) do
        splitted = String.split(filename, ".")
        if length(splitted) > 1 do
            List.last(splitted)
        else
            ""
        end
    end
end
