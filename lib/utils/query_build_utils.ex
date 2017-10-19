defmodule TicketingSystem.Utils.QueryBuildUtils do

  import Ecto.Query, warn: false


  def update_query_map(query_map: query_map, field: field, value: value, search_type: search_type) do
    %{ field => %{"assoc" => [],
    "search_term" => value, "search_type" => search_type}}
    |> Map.merge(query_map["search"])
    |> insert_into_map("search", query_map)
  end

  def add_filters_to_query_map(query_map: query_map, fieds: field_values) do
    Enum.filter(field_values, fn ({field, value}) -> field != nil && value != nil end)
    |> Enum.map(fn ({field, value}) ->
        update_query_map(query_map: query_map, field: field, value: value, search_type: "eq")
    end)
    |> Enum.reduce(%{}, &Map.merge/2)
  end


  defp insert_into_map(map_to_insert, key, map_to_update) do
    Map.put(map_to_update, key, map_to_insert)
  end
end
