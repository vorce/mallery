# Mallery

Mallery is a simple image gallery that can be populated by sending emails with
image attachments.

The email subject will be used as a description for the attached images.
The email attachment filename will be used as name.

All images will be resized to 400x300 to show thumbnails in the gallery.
This thumbnail links to the original variant.

Some needed environment variables before starting:

- CLOUD_IO_TOKEN: Token for cloudimage.io
- AWS_ACCESS_KEY_ID: Key id for aws (used for s3)
- AWS_SECRET_ACCESS_KEY: Access key for aws (used for s3)

## How it works

### 1. Get images from incoming email request

This part has only been tested with mailgun. You need to forward emails to
the /mailgun endpoint. Emails without any image attachments will not be processed.

If you'd like mailgun to only forward messages that have attachments you can use
the following filter rule: `match_header("Content-Type", "^multipart/mixed(.*)$")`

### 2. Upload images to cloud

The /mailgun endpoint offers each image attachment as a separate work item.
When all of the items have been uploaded (only S3 supported) the request is considered done.
All images will go to the same bucket at the moment.

### 3. Persist completed tasks' urls

After successful uploads, each url for the images are then saved to db.
cloudimage.io is used to resize the images into suitable thumbnails when a gallery is requested.

*Everything that is persited can be viewed (and edited) on the /images endpoint*. Disable it for production.

## Endpoints

- Global html gallery that shows all images: `/gallery/`
- To view a user's html gallery go to `/gallery/<user>`, where user = email address.
- JSON API:
  - GET: `/api/gallery`, `/api/gallery/<user>`
  - GET/DELTE/PUT: `/api/image/<id>`

## Handy test examples

Starting an "incoming image attachment" job from iex:

  Mallery.Work.S3Upload.call(:image_pool, {:process, [%Mallery.Work.Item{file: "/path/to/my/file.png", id: "somerandomid", name: "file.png", content_type: "image/png", description: "Hello"}]})

Sending an email with attachment via mailgun:

  curl -s --user 'my:apikey' \
    https://api.mailgun.net/v3/mysandbox.mailgun.org/messages \
    -F from='Foo <foo@mysandbox.mailgun.org>' \
    -F to='alice@mysandbox.mailgun.org' \
    -F subject='Hello' \
    -F text='Text' \
    -F attachment=@/path/to/my/file.png

## TODO

- Json endpoing to galleries
- Use channels to notify on new images and show them

---

To start your Mallery:

  1. Install dependencies with `mix deps.get`
  2. Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  3. Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check deployment guides](http://www.phoenixframework.org/docs/deployment).
