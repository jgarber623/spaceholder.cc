/**
 * Cloudflare Pages Function
 *
 * Responds to `GET https://spaceholder.cc/[dimensions]` where `[dimensions]` is
 * either a single `width` integer or a combined `width` and `height` string
 * joined by an `x`.
 *
 * @param {EventContext} context An EventContext instance.
 * @returns {Response} Most likely a 302 redirect.
 * @see {@link https://developers.cloudflare.com/pages/platform/functions/api-reference/}
 */
export async function onRequestGet(context) {
  let [width, height = width] = context.params.dimensions.split("x");

  width = Number.parseInt(width, 10);
  height = Number.parseInt(height, 10);

  if (Number.isNaN(width) || Number.isNaN(height) || width > 4000 || height > 4000) {
    return await context.next();
  }

  const candidates = [
    "heic0406a.jpg",
    "heic0604a.jpg",
    "heic0910i.jpg",
    "heic1011a.jpg",
    "heic1302a.jpg",
    "heic1501a.jpg",
    "heic1509a.jpg",
    "heic1608a.jpg",
    "heic1808a.jpg",
  ];

  const fit = "cover";
  const quality = 60;
  const url = candidates[Math.floor(Math.random() * candidates.length)];

  const params = new URLSearchParams({ fit, height, quality, url, width });

  const response = await fetch(`${context.env.NETLIFY_IMAGE_CDN_URL}?${params}`);

  return new Response(await response.blob(), {
    headers: {
      "cache-control": "public, max-age=3600",
      "content-type": "image/jpeg",
    },
  });
}
