defmodule Mallery.S3Client do
  use ExAws.S3.Client, otp_app: :mallery
end