# RssReader

To start your Phoenix server:

  * Setup the project with `mix setup`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix

### Notes

```
HTTPoison.start 
{:ok, %HTTPoison.Response{body: body}} = HTTPoison.get("https://joelholmes.dev/posts/index.xml")  
{:ok, feed, _} = FeederEx.parse(body)
Enum.map feed.entries, fn(entry) -> %{id: (:crypto.hash(:sha256, entry.id) |> Base.encode16()) , url: entry.link, updated: entry.updated} end 
```