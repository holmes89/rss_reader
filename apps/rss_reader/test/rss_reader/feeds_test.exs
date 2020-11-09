defmodule RssReader.FeedsTest do
  use RssReader.DataCase

  alias RssReader.Feeds

  describe "sources" do
    alias RssReader.Feeds.Source

    @valid_attrs %{name: "some name", url: "some url"}
    @update_attrs %{name: "some updated name", url: "some updated url"}
    @invalid_attrs %{name: nil, url: nil}

    def source_fixture(attrs \\ %{}) do
      {:ok, source} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Feeds.create_source()

      source
    end

    test "list_sources/0 returns all sources" do
      source = source_fixture()
      assert Feeds.list_sources() == [source]
    end

    test "get_source!/1 returns the source with given id" do
      source = source_fixture()
      assert Feeds.get_source!(source.id) == source
    end

    test "create_source/1 with valid data creates a source" do
      assert {:ok, %Source{} = source} = Feeds.create_source(@valid_attrs)
      assert source.name == "some name"
      assert source.url == "some url"
    end

    test "create_source/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Feeds.create_source(@invalid_attrs)
    end

    test "update_source/2 with valid data updates the source" do
      source = source_fixture()
      assert {:ok, %Source{} = source} = Feeds.update_source(source, @update_attrs)
      assert source.name == "some updated name"
      assert source.url == "some updated url"
    end

    test "update_source/2 with invalid data returns error changeset" do
      source = source_fixture()
      assert {:error, %Ecto.Changeset{}} = Feeds.update_source(source, @invalid_attrs)
      assert source == Feeds.get_source!(source.id)
    end

    test "delete_source/1 deletes the source" do
      source = source_fixture()
      assert {:ok, %Source{}} = Feeds.delete_source(source)
      assert_raise Ecto.NoResultsError, fn -> Feeds.get_source!(source.id) end
    end

    test "change_source/1 returns a source changeset" do
      source = source_fixture()
      assert %Ecto.Changeset{} = Feeds.change_source(source)
    end
  end

  describe "entries" do
    alias RssReader.Feeds.Entry

    @valid_attrs %{description: "some description", entry_date: ~D[2010-04-17], favorited: true, img: "some img", name: "some name", read: true, url: "some url", uuid: "some uuid"}
    @update_attrs %{description: "some updated description", entry_date: ~D[2011-05-18], favorited: false, img: "some updated img", name: "some updated name", read: false, url: "some updated url", uuid: "some updated uuid"}
    @invalid_attrs %{description: nil, entry_date: nil, favorited: nil, img: nil, name: nil, read: nil, url: nil, uuid: nil}

    def entry_fixture(attrs \\ %{}) do
      {:ok, entry} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Feeds.create_entry()

      entry
    end

    test "list_entries/0 returns all entries" do
      entry = entry_fixture()
      assert Feeds.list_entries() == [entry]
    end

    test "get_entry!/1 returns the entry with given id" do
      entry = entry_fixture()
      assert Feeds.get_entry!(entry.id) == entry
    end

    test "create_entry/1 with valid data creates a entry" do
      assert {:ok, %Entry{} = entry} = Feeds.create_entry(@valid_attrs)
      assert entry.description == "some description"
      assert entry.entry_date == ~D[2010-04-17]
      assert entry.favorited == true
      assert entry.img == "some img"
      assert entry.name == "some name"
      assert entry.read == true
      assert entry.url == "some url"
      assert entry.uuid == "some uuid"
    end

    test "create_entry/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Feeds.create_entry(@invalid_attrs)
    end

    test "update_entry/2 with valid data updates the entry" do
      entry = entry_fixture()
      assert {:ok, %Entry{} = entry} = Feeds.update_entry(entry, @update_attrs)
      assert entry.description == "some updated description"
      assert entry.entry_date == ~D[2011-05-18]
      assert entry.favorited == false
      assert entry.img == "some updated img"
      assert entry.name == "some updated name"
      assert entry.read == false
      assert entry.url == "some updated url"
      assert entry.uuid == "some updated uuid"
    end

    test "update_entry/2 with invalid data returns error changeset" do
      entry = entry_fixture()
      assert {:error, %Ecto.Changeset{}} = Feeds.update_entry(entry, @invalid_attrs)
      assert entry == Feeds.get_entry!(entry.id)
    end

    test "delete_entry/1 deletes the entry" do
      entry = entry_fixture()
      assert {:ok, %Entry{}} = Feeds.delete_entry(entry)
      assert_raise Ecto.NoResultsError, fn -> Feeds.get_entry!(entry.id) end
    end

    test "change_entry/1 returns a entry changeset" do
      entry = entry_fixture()
      assert %Ecto.Changeset{} = Feeds.change_entry(entry)
    end
  end
end
