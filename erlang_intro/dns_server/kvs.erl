-module(kvs).

-import(io, [format/2]).
-export([start/0, store/2, lookup/1]).

start() ->
    Pid = register(kvs, spawn(fun() -> loop() end)),
    io:format("Pid:~p~n", [Pid]),
    true.


store(Key, Value) -> rpc({store, Key, Value}).


rpc(Q) ->
    kvs ! {self(), Q},
    receive
        {kvs, Reply} ->
            Reply
    end.

lookup(Key) -> rpc({lookup, Key}).

loop() ->
    receive
        {From, {store, Key, Value}} ->
            put(Key, {ok, Value}),
            From ! {kvs, true},
            loop();
        {From, {lookup, Key}} ->
            From ! {kvs, get(Key)},
            loop()
    end.
