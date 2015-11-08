defmodule Mallery.MailgunControllerTest do
  use Mallery.ConnCase

  test "POST with image attachments to /mailgun/" do
    incoming = %{"Content-Type" => "multipart/mixed; boundary=\"601b35a1d75d4d17980a96eeb4ea3846\"",
      "From" => "Attachment test <mailgun@sandbox1fa2ccdc3a014f9385b820d3909d49c9.mailgun.org>",
      "Message-Id" => "<20151107155524.33554.6368@sandbox1fa2ccdc3a014f9385b820d3909d49c9.mailgun.org>",
      "Mime-Version" => "1.0",
      "Received" => "by luna.mailgun.net with HTTP; Sat, 07 Nov 2015 15:55:24 +0000",
      "Subject" => "Attachment test 14",
      "To" => "alice@sandbox1fa2ccdc3a014f9385b820d3909d49c9.mailgun.org",
      "attachment-1" => %Plug.Upload{content_type: "application/pdf",filename: "funsrv.pdf", path: "/tmp/plug-1446/multipart-911727-268604-1"},
      "attachment-2" => %Plug.Upload{content_type: "image/png",filename: "happy.png", path: "/tmp/plug-1446/multipart-911727-338417-1"},
      "attachment-3" => %Plug.Upload{content_type: "image/png",filename: "foo.png", path: "/tmp/plug-1446/multipart-911727-338413-2"},
      "attachment-count" => "3", "body-plain" => "Mail w attachments",
      "from" => "Attachment test <mailgun@sandbox1fa2ccdc3a014f9385b820d3909d49c9.mailgun.org>",
      "message-headers" => "[[\"Received\", \"by luna.mailgun.net with HTTP; Sat, 07 Nov 2015 15:55:24 +0000\"], [\"Message-Id\", \"<20151107155524.33554.6368@sandbox1fa2ccdc3a014f9385b820d3909d49c9.mailgun.org>\"], [\"To\", \"alice@sandbox1fa2ccdc3a014f9385b820d3909d49c9.mailgun.org\"], [\"From\", \"Attachment test <mailgun@sandbox1fa2ccdc3a014f9385b820d3909d49c9.mailgun.org>\"], [\"Subject\", \"Attachment test 14\"], [\"Mime-Version\", \"1.0\"], [\"Content-Type\", \"multipart/mixed; boundary=\\\"601b35a1d75d4d17980a96eeb4ea3846\\\"\"]]",
      "recipient" => "alice@sandbox1fa2ccdc3a014f9385b820d3909d49c9.mailgun.org",
      "sender" => "mailgun@sandbox1fa2ccdc3a014f9385b820d3909d49c9.mailgun.org",
      "signature" => "239c1ce5484181cd594901c7a3170d021ebd71538d7817ab53022bde385c9c11",
      "stripped-html" => "<p>Mail w attachments</p>", "stripped-signature" => "",
      "stripped-text" => "Mail w attachments", "subject" => "Attachment test 14",
      "timestamp" => "1446911726",
      "token" => "8f89d80d616a7516768183be87dba1312b460ef28ac4434b12"}

    conn = post(conn(), "/mailgun", incoming)
    assert response(conn, 200)
  end

  test "POST with no attachments to /mailgun/" do
    conn = post(conn(), "/mailgun", %{"foo" => "bar"})
    assert response(conn, 406)
  end

  test "POST with no image attachments" do
    incoming = %{"Content-Type" => "multipart/mixed; boundary=\"601b35a1d75d4d17980a96eeb4ea3846\"",
      "From" => "Attachment test <mailgun@sandbox1fa2ccdc3a014f9385b820d3909d49c9.mailgun.org>",
      "Message-Id" => "<20151107155524.33554.6368@sandbox1fa2ccdc3a014f9385b820d3909d49c9.mailgun.org>",
      "Mime-Version" => "1.0",
      "Received" => "by luna.mailgun.net with HTTP; Sat, 07 Nov 2015 15:55:24 +0000",
      "Subject" => "Attachment test 14",
      "To" => "alice@sandbox1fa2ccdc3a014f9385b820d3909d49c9.mailgun.org",
      "attachment-1" => %Plug.Upload{content_type: "application/pdf",filename: "funsrv.pdf", path: "/tmp/plug-1446/multipart-911727-268604-1"},
      "attachment-count" => "1", "body-plain" => "Mail w attachments",
      "from" => "Attachment test <mailgun@sandbox1fa2ccdc3a014f9385b820d3909d49c9.mailgun.org>",
      "message-headers" => "[[\"Received\", \"by luna.mailgun.net with HTTP; Sat, 07 Nov 2015 15:55:24 +0000\"], [\"Message-Id\", \"<20151107155524.33554.6368@sandbox1fa2ccdc3a014f9385b820d3909d49c9.mailgun.org>\"], [\"To\", \"alice@sandbox1fa2ccdc3a014f9385b820d3909d49c9.mailgun.org\"], [\"From\", \"Attachment test <mailgun@sandbox1fa2ccdc3a014f9385b820d3909d49c9.mailgun.org>\"], [\"Subject\", \"Attachment test 14\"], [\"Mime-Version\", \"1.0\"], [\"Content-Type\", \"multipart/mixed; boundary=\\\"601b35a1d75d4d17980a96eeb4ea3846\\\"\"]]",
      "recipient" => "alice@sandbox1fa2ccdc3a014f9385b820d3909d49c9.mailgun.org",
      "sender" => "mailgun@sandbox1fa2ccdc3a014f9385b820d3909d49c9.mailgun.org",
      "signature" => "239c1ce5484181cd594901c7a3170d021ebd71538d7817ab53022bde385c9c11",
      "stripped-html" => "<p>Mail w attachments</p>", "stripped-signature" => "",
      "stripped-text" => "Mail w attachments", "subject" => "Attachment test 14",
      "timestamp" => "1446911726",
      "token" => "8f89d80d616a7516768183be87dba1312b460ef28ac4434b12"}
    conn = post(conn(), "/mailgun", incoming)
    assert response(conn, 406)
  end
end