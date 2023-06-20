const functions = require('@google-cloud/functions-framework');
const { Storage } = require('@google-cloud/storage');

const sharp = require('sharp');

const { GCP_BUCKET_NAME } = process.env;

functions.http('transformImage', async (request, response) => {
  const requestId = request.get('x-nf-request-id');

  if (typeof request.query.transform === 'undefined') {
    return response.redirect(301, 'https://spaceholder.cc');
  }

  let [width, height = width] = request.query.transform.split('/');

  width = parseInt(width, 10);
  height = parseInt(height, 10);

  if (isNaN(width) || isNaN(height) || width > 4000 || height > 4000) {
    return response.status(400).end();
  }

  console.log(requestId, 'Generating transform with dimensions:', width, height);

  // Retrieve a list of all objects in the bucket
  const storage = new Storage();
  const [files] = await storage.bucket(GCP_BUCKET_NAME).getFiles();

  // Choose a random object
  const file = files[Math.floor(Math.random() * files.length)];

  console.log(requestId, 'Randomly selected file:', file.name);

  // Load that object into memory
  //
  // Notes:
  //   - `download()` returns a single-element Array
  //   - `contents` is a Buffer
  const [contents] = await storage.bucket(GCP_BUCKET_NAME).file(file.name).download();

  // Resize and transform the object and return a Buffer
  const data = await sharp(contents)
    .resize(width, height)
    .jpeg({
      progressive: true,
      quality: 60
    })
    .toBuffer();

  response
    .set({
      'Cache-Control': 'public, max-age=3600',
      'Content-Type': 'image/jpeg'
    })
    .send(data);
});
