defmodule PowerSupply do
	# purpose of this module
	#   - simulate the basic functionalities of a real PowerSupply
	#   - response to KiNET discover, blinkScan, query, etc

  # use Application
	use GenServer.Behaviour

	alias PowerSupply.Settings

  # See http://elixir-lang.org/docs/stable/Application.html
  # for more information on OTP Applications
  # def start(_type, _args) do
  #   FakePDS.Supervisor.start_link
  # end

	#define PDS Settings	
	defmodule Settings do
		defstruct ip: "0.0.0.0", macAddress: "FF:FF:FF:FF", name: "UNKNOWN POWERSUPPLY"

		def get_ip(settings = %PowerSupply.Settings{}) do
			settings.ip
		end

	end

	###### public API ######
  def start_link do
		IO.puts "in start_link"
    :gen_server.start_link(__MODULE__, [], [])	# will call init to initialize
  end

	def create(pid) do
		IO.puts "in create"
		:gen_server.cast(pid, {:create})
	end

	def create(pid, ipStr, macStr, nameStr) do
		:gen_server.call(pid, {:create, ipStr, macStr, nameStr})		
	end

	def hello do
		IO.puts "This is a fake PDS \n\n"
	end

	def bye do
		IO.puts "Terminate communication with current PDS. \n\n"
	end


	###### Callbacks ######
	# Callback - invoke when Server is started
	def init(_args) do
		device = %Settings{}
		IO.puts "PowerSupply init"
		IO.inspect(device)
		{:ok, device}
	end

	# Callbacks - work with synchronous messages
	# def handle_call
	def handle_cast(:create, device) do
		IO.puts "In handle_cast::create/0 \n"
		# , "10.1.3.19", "FF:EE:CC:DD", "testPDS"
		newDevice = %Settings{device | ip: "10.1.5.19", macAddress: "FF:EE:CC:DD", name: "testPDS"}
		{:reply, newDevice}		
	end	

	def handle_cast({:create, %Settings{}}, device) do
		IO.puts "In handle_cast::create/1 \n"
		# , "10.1.3.19", "FF:EE:CC:DD", "testPDS"
		newDevice = %Settings{device | ip: "10.1.5.19", macAddress: "FF:EE:CC:DD", name: "testPDS"}
		{:reply, newDevice}		
	end	

	def handle_call({:create, ipStr, macStr, nameStr}, _from, device) do
		newDevice = %Settings{device | ip: ipStr, macAddress: macStr, name: nameStr}
		IO.puts "In handle_case::create/3"
		{:reply, newDevice}		
	end	


	# Callbacks - handle asynchronous calls


	# handle the PDS "bye" message
	def handle_info({:stop, _from}, device) do
		IO.puts "Bye fakePDS \n\n"
		bye
		{:noreply, device}
	end

	# Callbacks - handle message
	# def handle_info({:getIP}, state) do


end
