defmodule Mallery.MailgunControllerTest do
  use Mallery.ConnCase

  test "POST with attachments to /mailgun/" do
    incoming = %{"Content-Type" => "multipart/mixed; boundary=\"b8759f3eea334ef0ae7fa1445d074bab\"",
      "From" => "Attachment test <mailgun@sandbox1fa2ccdc3a014f9385b820d3909d49c9.mailgun.org>",
      "Message-Id" => "<20151106184957.10032.85962@sandbox1fa2ccdc3a014f9385b820d3909d49c9.mailgun.org>",
      "Mime-Version" => "1.0",
      "Received" => "by luna.mailgun.net with HTTP; Fri, 06 Nov 2015 18:49:57 +0000",
      "Subject" => "Attachment test 6",
      "To" => "alice@sandbox1fa2ccdc3a014f9385b820d3909d49c9.mailgun.org",
      "attachments" => "[{\"url\": \"https://api.mailgun.net/v2/domains/sandbox1fa2ccdc3a014f9385b820d3909d49c9.mailgun.org/messages/WyJmOWQ5ZjZmYjEwIiwgWyIxOGEzYTcyOS1iNDAwLTRkYjEtOTRiZi0zOWUzOGUzNThjMzMiLCAiZDMxYzE5OWMtNjYwYi00ZGJlLTk2ZGEtOTNiNzExNDM0ODBlIiwgIjlkOWE2M2QxLTZkMzUtNDhjMS1iOWM4LTQxMDAzYmZhMzVlZSJdLCAibWFpbGd1biIsICJvZGluIl0=/attachments/0\", \"content-type\": \"image/png\", \"name\": \"happy.png\", \"size\": 51079},{\"url\": \"https://api.mailgun.net/v2/domains/sandbox1fa2ccdc3a014f9385b820d3909d49c9.mailgun.org/messages/WyJmOWQ5ZjZmYjEwIiwgWyIxOGEzYTcyOS1iNDAwLTRkYjEtOTRiZi0zOWUzOGUzNThjMzMiLCAiZDMxYzE5OWMtNjYwYi00ZGJlLTk2ZGEtOTNiNzExNDM0ODBlIiwgIjlkOWE2M2QxLTZkMzUtNDhjMS1iOWM4LTQxMDAzYmZhMzVlZSJdLCAibWFpbGd1biIsICJvZGluIl0=/attachments/1\", \"content-type\": \"application/pdf\", \"name\": \"funsrv.pdf\", \"size\": 221619}]",
      "body-plain" => "Mail w attachments",
      "domain" => "sandbox1fa2ccdc3a014f9385b820d3909d49c9.mailgun.org",
      "from" => "Attachment test <mailgun@sandbox1fa2ccdc3a014f9385b820d3909d49c9.mailgun.org>",
      "message-headers" => "[[\"Received\", \"by luna.mailgun.net with HTTP; Fri, 06 Nov 2015 18:49:57 +0000\"],
        [\"Message-Id\", \"<20151106184957.10032.85962@sandbox1fa2ccdc3a014f9385b820d3909d49c9.mailgun.org>\"],
        [\"To\", \"alice@sandbox1fa2ccdc3a014f9385b820d3909d49c9.mailgun.org\"],
        [\"From\", \"Attachment test <mailgun@sandbox1fa2ccdc3a014f9385b820d3909d49c9.mailgun.org>\"],
        [\"Subject\", \"Attachment test 6\"],
        [\"Mime-Version\", \"1.0\"],
        [\"Content-Type\", \"multipart/mixed; boundary=\\\"b8759f3eea334ef0ae7fa1445d074bab\\\"\"]]",
      "message-url" => "https://api.mailgun.net/v2/domains/sandbox1fa2ccdc3a014f9385b820d3909d49c9.mailgun.org/messages/WyJmOWQ5ZjZmYjEwIiwgWyIxOGEzYTcyOS1iNDAwLTRkYjEtOTRiZi0zOWUzOGUzNThjMzMiLCAiZDMxYzE5OWMtNjYwYi00ZGJlLTk2ZGEtOTNiNzExNDM0ODBlIiwgIjlkOWE2M2QxLTZkMzUtNDhjMS1iOWM4LTQxMDAzYmZhMzVlZSJdLCAibWFpbGd1biIsICJvZGluIl0=",
      "recipient" => "alice@sandbox1fa2ccdc3a014f9385b820d3909d49c9.mailgun.org",
      "sender" => "mailgun@sandbox1fa2ccdc3a014f9385b820d3909d49c9.mailgun.org",
      "signature" => "ded0cf44673eedd05d673f064cf633be0f0fc2ec44c727f8b8c40dfb86ba5c77",
      "stripped-html" => "<p>Mail w attachments</p>",
      "stripped-signature" => "",
      "stripped-text" => "Mail w attachments",
      "subject" => "Attachment test 6",
      "timestamp" => "1446835799",
      "token" => "d9824aac65470ed0bd4feee7d1e026b48a92240872f0f68304"}
    conn = post(conn(), "/mailgun", incoming)
    assert response(conn, 200)
  end

  test "POST with no attachments to /mailgun/" do
    incoming = %{"Content-Transfer-Encoding" => "7bit",
    "Content-Type" => "text/plain; charset=\"ascii\"",
    "From" => "Foo <foo@bar.org>",
    "Message-Id" => "<20151106175852.19534.36341@bar.org>",
    "Mime-Version" => "1.0",
    "Received" => "",
    "Subject" => "Hello test",
    "To" => "alice@baz.com",
    "body-plain" => "blabla",
    "domain" => "sandbox1fa2ccdc3a014f9385b820d3909d49c9.mailgun.org",
    "from" => "Foo <foo@bar.org>",
    "message-headers" => "[[\"Received\", \"\"],
      [\"Message-Id\", \"<20151106175852.19534.36341@bar.org>\"],
      [\"To\", \"alice@baz.com\"], [\"From\", \"Foo <foo@bar.org>\"],
      [\"Subject\", \"Hello test\"], [\"Content-Type\", \"text/plain; charset=\\\"ascii\\\"\"],
      [\"Mime-Version\", \"1.0\"], [\"Content-Transfer-Encoding\", \"7bit\"]]",
    "message-url" => "https://api.mailgun.net/v2/domains/sandbox1fa2ccdc3a014f9385b820d3909d49c9.mailgun.org/messages/WyJlNWQ3ZjFiYTMwIiwgWyI4ZTkxZDUwZS04ZDc1LTRmMjctODVkZC04NDJlODU1NGJkNDAiXSwgIm1haWxndW4iLCAidGhvciJd",
    "recipient" => "alice@baz.com",
    "sender" => "mailgun@sandbox1fa2ccdc3a014f9385b820d3909d49c9.mailgun.org",
    "signature" => "c8306caa772de09378286abd2e24722a34e77c460a7198f2721251f06cb0128c",
    "stripped-html" => "<p>blabla</p>",
    "stripped-signature" => "",
    "stripped-text" => "blabla",
    "subject" => "Hello test",
    "timestamp" => "1446832734",
    "token" => "4e36d830430b0687da6e628be71fa3fc76fd045ff956ab5fd8"}
    conn = post(conn(), "/mailgun", incoming)
    assert response(conn, 406)

    conn = post(conn, "/mailgun", %{})
    assert response(conn, 406)
  end

  test "POST with no image attachments" do
    incoming = %{"attachments" =>
      "[{\"url\": \"https://api.mailgun.net/v2/domains/sandbox1fa2ccdc3a014f9385b820d3909d49c9.mailgun.org/messages/WyJmOWQ5ZjZmYjEwIiwgWyIxOGEzYTcyOS1iNDAwLTRkYjEtOTRiZi0zOWUzOGUzNThjMzMiLCAiZDMxYzE5OWMtNjYwYi00ZGJlLTk2ZGEtOTNiNzExNDM0ODBlIiwgIjlkOWE2M2QxLTZkMzUtNDhjMS1iOWM4LTQxMDAzYmZhMzVlZSJdLCAibWFpbGd1biIsICJvZGluIl0=/attachments/1\", \"content-type\": \"application/pdf\", \"name\": \"funsrv.pdf\", \"size\": 221619}]"}
    conn = post(conn, "/mailgun", incoming)
    assert response(conn, 406)
  end
end