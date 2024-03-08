import { Storage } from "@google-cloud/storage";
import sharp from "sharp";

const { GCP_BUCKET_NAME } = process.env;

export const transformImage = async (request, response) => {

  console.log(sharp);

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
