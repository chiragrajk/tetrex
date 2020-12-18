defmodule TetrexWeb.GameLive do
  use TetrexWeb, :live_view
  alias Tetrex.Tetromino


  def mount(_params, _session, socket) do
    if connected?(socket) do
      :timer.send_interval(500, :tick)
    end

    {
      :ok,
      socket
      |> new_tetromino
      |> show
    }
  end

  def render(assigns) do
    ~L"""
    <section class="phx-hero">
      <h1>Welcome to Tetrex</h1>
      <%= render_board(assigns) %>
      <pre>
        <%= inspect @tetro %>
      </pre>
    </section>
    """
  end

  defp render_board(assigns) do
    ~L"""
    <svg width="200" height="400">
      <rect width="200" height="400" style="fill:rgb(0,0,0);" />
      <%= render_points(assigns) %>
    </svg>
    """
  end

  defp render_points(assigns) do
    ~L"""
    <%= for {x, y} <- @points do %>
      <rect
        width="20" height="20"
        x="<%= (x - 1) * 20 %>" y="<%= (y - 1) * 20 %>"
        style="fill:<%= color(@tetro.shape) %>;" />
    <% end %>
    """
  end

  defp color(:l), do: "orange"
  defp color(:j), do: "blue"
  defp color(:s), do: "green"
  defp color(:z), do: "red"
  defp color(:i), do: "cyan"
  defp color(:o), do: "yellow"
  defp color(:t), do: "purple"


  defp new_tetromino(socket) do
    assign(socket, tetro: Tetromino.new_random())
  end

  defp show(socket) do
    assign(socket,
      points: Tetromino.show(socket.assigns.tetro)
    )
  end


  def down(%{assigns: %{tetro: %{location: {_, 20}}}}=socket) do
    socket
    |> new_tetromino
    |> show
  end

  def down(%{assigns: %{tetro: tetro}}=socket) do
    assign(socket, tetro: Tetromino.down(tetro))
  end

  def handle_info(:tick, socket) do
    {:noreply, socket |> down |> show}
  end
end
