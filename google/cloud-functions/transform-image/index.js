const { GCP_BUCKET_NAME } = process.env;

/**
 * A Google Cloud Functions HTTP function that returns a random image resized
 * and cropped to the supplied width and height..
 *
 * @param {Request} request An Express Request object.
 * @param {Response} response An Express Response object.
 * @returns {Response} Most likely a Blob.
 * @see {@link https://expressjs.com/en/4x/api.html#req}
 * @see {@link https://expressjs.com/en/4x/api.html#res}
 */
export const transformImage = async (request, response) => {
  if (request.method !== "POST") {
    return response.set("allow", "POST").status(405).end();
  }

  if (request.get("content-type") !== "application/x-www-form-urlencoded") {
    return response.status(415).end();
  }

  let { width, height = width } = request.body;

  width = Number.parseInt(width, 10);
  height = Number.parseInt(height, 10);

  if (Number.isNaN(width) || Number.isNaN(height) || width > 4000 || height > 4000) {
    return response.status(400).end();
  }

  console.log("Generating transform with dimensions:", width, height);

  const { Storage } = await import("@google-cloud/storage");

  // Retrieve a list of all objects in the bucket
  const storage = new Storage();
  const [files] = await storage.bucket(GCP_BUCKET_NAME).getFiles();

  // Choose a random object
  const file = files[Math.floor(Math.random() * files.length)];

  console.log("Randomly selected file:", file.name);

  // Load that object into memory
  //
  // Notes:
  //   - `download()` returns a single-element Array
  //   - `contents` is a Buffer
  const [contents] = await storage.bucket(GCP_BUCKET_NAME).file(file.name).download();

  const { default: sharp } = await import("sharp");

  // Resize and transform the object and return a Buffer
  const data = await sharp(contents)
    .resize(width, height)
    .jpeg({
      progressive: true,
      quality: 60,
    })
    .toBuffer();

  response
    .set({
      "cache-control": "public, max-age=3600",
      "content-type": "image/jpeg",
    })
    .send(data);
};
