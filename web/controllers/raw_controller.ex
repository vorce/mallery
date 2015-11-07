defmodule Mallery.RawController do
  use Mallery.Web, :controller

  require Logger

  def show(conn, %{"id" => id}) do
    raw_dir = Application.get_env(:mallery, :raw_dir)
    
    target_file = "#{raw_dir}/#{id}"
    Logger.debug("Request for raw file: #{target_file}")

    case File.exists?(target_file) do
      true ->
        image_data = File.read!(target_file)
        conn
        |> resp(200, image_data)
      false ->
        send_resp(conn, 404, "")
    end
  end
end