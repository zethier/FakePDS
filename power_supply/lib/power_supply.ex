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
    :gen_server.start_link(__MODULE__, [], [])
  end

	def create(pid) do
		:gen_server.call(pid, {:create})
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
	def init() do
		IO.puts "PowerSupply init."
		{:ok, pid} = :gen_server.start_link(__MODULE__, [], [])
		device = %Settings{}
		{:ok, device}
	end

	# Callbacks - work with synchronous messages
	# def handle_call
	def handle_call(:create, _from, device) do
		# , "10.1.3.19", "FF:EE:CC:DD", "testPDS"
		newDevice = %Settings{device | ip: "10.1.5.19", macAddress: "FF:EE:CC:DD", name: "testPDS"}
		IO.puts "In handle_case::create/0"
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
