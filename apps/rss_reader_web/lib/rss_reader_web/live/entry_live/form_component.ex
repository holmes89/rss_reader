defmodule RssReaderWeb.EntryLive.FormComponent do
  use RssReaderWeb, :live_component

  alias RssReader.Feeds

  @impl true
  def update(%{entry: entry} = assigns, socket) do
    changeset = Feeds.change_entry(entry)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"entry" => entry_params}, socket) do
    changeset =
      socket.assigns.entry
      |> Feeds.change_entry(entry_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"entry" => entry_params}, socket) do
    save_entry(socket, socket.assigns.action, entry_params)
  end

  defp save_entry(socket, :edit, entry_params) do
    case Feeds.update_entry(socket.assigns.entry, entry_params) do
      {:ok, _entry} ->
        {:noreply,
         socket
         |> put_flash(:info, "Entry updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_entry(socket, :new, entry_params) do
    case Feeds.create_entry(entry_params) do
      {:ok, _entry} ->
        {:noreply,
         socket
         |> put_flash(:info, "Entry created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end