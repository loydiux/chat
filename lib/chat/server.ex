defmodule chat.server do
     use GenServer
     ## Client API

  @doc """
  Starts the registry.
  """
  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  @doc """
  Looks up the bucket pid for `name` stored in `server`.

  Returns `{:ok, pid}` if the bucket exists, `:error` otherwise.
  """
  def lookup(server, name) do
    GenServer.call(server, {:lookup, name})
  end
   
  @doc """
  Send menssage function
  """
  def sendMenssage(server, name, menssage){
      GenServer.call(server, {:sendMenssage, name, menssage})
  }

  @doc """
  storage name
  """
  def registerName(server, name){
     GenServer.call(server, {:registerName, name})
  }

  @doc """
  Ensures there is a bucket associated with the given `name` in `server`.
  """
  def create(server, name) do
    GenServer.cast(server, {:create, name})
  end

  ## Server Callbacks

  def init(:ok) do
    {:ok, %{}}
  end
   
  def handle_call({:registerName, name}, _from, names){
      if Map.has_key?(names, name) do
          {:reply, "Error message", names}
      end
    else
       names= Map.put(names, name, true);
       {:reply, "Ok", names }
    end
  }

  def handle_call({:sendMenssage, name, menssage}, _from, names) do
    {:reply, Map.fetch(names, name), names}
  end

  def handle_cast({:create, name}, names) do
    if Map.has_key?(names, name) do
      {:noreply, names}
    else
      {:ok, bucket} = chat.Bucket.start_link([])
      {:noreply, Map.put(names, name, bucket)}
    end
  end
end
    
end