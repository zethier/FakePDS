# fakePDS.ex

defmodule FakePDS do
	use GenServer.Behaviour
	
	# Callback - invoke when Server is started
	def init() do
		IO.puts "fakePDS init."
		:gen_server.start_link(__MODULE__, [:hello], [])
		# process_flag(trap_exit, true)
		# {ok, initialized}
	end
	
	# Callbacks - work with synchronous messages
	# def handle_call
	
	# Callbacks - handle asynchronous calls
	def handle_cast({:getIP}, state) do
		{:noreply, state}
	end
	
	# Callbacks - handle message
	# def handle_info
	
	
	
	# public API
	def getIP do
		"10.1.5.21"
	end
	
	def hello do
		IO.puts "This is a fake PDS \n\n"
	end
	
end