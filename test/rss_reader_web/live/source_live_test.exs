defmodule RssReaderWeb.SourceLiveTest do
  use RssReaderWeb.ConnCase

  import Phoenix.LiveViewTest

  alias RssReader.Feeds

  @create_attrs %{name: "some name", url: "some url"}
  @update_attrs %{name: "some updated name", url: "some updated url"}
  @invalid_attrs %{name: nil, url: nil}

  defp fixture(:source) do
    {:ok, source} = Feeds.create_source(@create_attrs)
    source
  end

  defp create_source(_) do
    source = fixture(:source)
    %{source: source}
  end

  describe "Index" do
    setup [:create_source]

    test "lists all sources", %{conn: conn, source: source} do
      {:ok, _index_live, html} = live(conn, Routes.source_index_path(conn, :index))

      assert html =~ "Listing Sources"
      assert html =~ source.name
    end

    test "saves new source", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.source_index_path(conn, :index))

      assert index_live |> element("a", "New Source") |> render_click() =~
               "New Source"

      assert_patch(index_live, Routes.source_index_path(conn, :new))

      assert index_live
             |> form("#source-form", source: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#source-form", source: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.source_index_path(conn, :index))

      assert html =~ "Source created successfully"
      assert html =~ "some name"
    end

    test "updates source in listing", %{conn: conn, source: source} do
      {:ok, index_live, _html} = live(conn, Routes.source_index_path(conn, :index))

      assert index_live |> element("#source-#{source.id} a", "Edit") |> render_click() =~
               "Edit Source"

      assert_patch(index_live, Routes.source_index_path(conn, :edit, source))

      assert index_live
             |> form("#source-form", source: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#source-form", source: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.source_index_path(conn, :index))

      assert html =~ "Source updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes source in listing", %{conn: conn, source: source} do
      {:ok, index_live, _html} = live(conn, Routes.source_index_path(conn, :index))

      assert index_live |> element("#source-#{source.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#source-#{source.id}")
    end
  end

  describe "Show" do
    setup [:create_source]

    test "displays source", %{conn: conn, source: source} do
      {:ok, _show_live, html} = live(conn, Routes.source_show_path(conn, :show, source))

      assert html =~ "Show Source"
      assert html =~ source.name
    end

    test "updates source within modal", %{conn: conn, source: source} do
      {:ok, show_live, _html} = live(conn, Routes.source_show_path(conn, :show, source))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Source"

      assert_patch(show_live, Routes.source_show_path(conn, :edit, source))

      assert show_live
             |> form("#source-form", source: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#source-form", source: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.source_show_path(conn, :show, source))

      assert html =~ "Source updated successfully"
      assert html =~ "some updated name"
    end
  end
end
