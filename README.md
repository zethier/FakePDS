Create a fake PDS Device.

To invoke from command line:
$ cd FakePDS/power_supply
$ iex -S mix

Erlang/OTP 17 [erts-6.0] [source] [64-bit] [smp:8:8] [async-threads:10] [hipe] [kernel-poll:false] [dtrace]

Interactive Elixir (0.13.2-dev) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)> result = PowerSupply.start_link  (start_link will call 'init')
in start_link
PowerSupply init
%PowerSupply.Settings{ip: "0.0.0.0", macAddress: "FF:FF:FF:FF",
 name: "UNKNOWN POWERSUPPLY"}
{:ok, #PID<0.77.0>}

iex(3)> elem(result, 1)
#PID<0.77.0>

iex(5)> PowerSupply.create(elem(result, 1), "10.1.3.19", "AA:BB:CC:DD", "test PDS")
In handle_case::create/3

iex(6)> elem = PowerSupply.create(elem(result, 1)) 
in create
In handle_cast::create/0 

:ok
%PowerSupply.Settings{ip: "10.1.5.19", macAddress: "FF:EE:CC:DD",
 name: "testPDS"}
