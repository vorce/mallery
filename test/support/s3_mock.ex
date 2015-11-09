defmodule Mallery.S3Mock do
  @behaviour ExAws.S3.Client

  def put_object(_bucket, _name, _data, _opts) do
    :ok
  end

  def config_root() do
    [s3: [region: "test-region"]]
  end
end