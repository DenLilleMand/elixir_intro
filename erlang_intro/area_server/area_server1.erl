-module(area_server1).

-import(io, [format/2]).
-export([start/0, area/2]).

start() ->
    Pid = spawn(fun loop/0),
    io:format("Pid:~p~n", [Pid]),
    Pid.

area(Pid, What) ->
    rpc(Pid, What).

rpc(Pid, Request) ->
    Pid ! {self(), Request},
    receive
        Resp -> Resp
    end.

loop() ->
    receive
        {From, {rectangle, Width, Ht}} ->
            From ! Width * Ht,
            loop();
        {From, {circle, R}} ->
            From ! 3.14159 * R * R,
            loop();
        {From, Other} ->
            From ! {error, Other},
            loop()
    end.
