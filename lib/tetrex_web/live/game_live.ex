defmodule TetrexWeb.GameLive do
  use TetrexWeb, :live_view

  alias Tetrex.Tetromino

  @impl true
  def mount(_params, _session, socket) do
    :timer.send_interval(500, :tick)
    {:ok, socket |> new_tetromino}
  end

  def render(assigns) do
    ~L"""
    <% {x, y} = @tetro.location %>
    <section class="phx-hero">
    <h1><%= "something" %></h1>
    <pre>
    shape: <%= @tetro.shape %>
    rotation: <%= @tetro.rotation %>
    location: {<%= x %>, <%= y %> }
    </pre>
    </section>
    """
  end

  def handle_info(:tick, socket) do
    {:noreply, down(socket)}
  end

  def down(%{assigns: %{tetro: tetro}} = socket) do
    assign(socket, tetro: Tetromino.down(tetro))
  end

  def new_tetromino(socket) do
    assign(socket, tetro: Tetromino.new_random)
  end
end
