/**
 * Cloudflare Pages Function
 *
 * Responds to `GET https://spaceholder.cc/[dimensions]` where `[dimensions]` is
 * either a single `width` integer or a combined `width` and `height` string
 * joined by an `x`.
 *
 * @see {@link https://developers.cloudflare.com/pages/platform/functions/api-reference/}
 *
 * @param {EventContext} context An EventContext instance.
 *
 * @returns {Response} Most likely a 302 redirect.
 */
export async function onRequestGet(context) {
  let [width, height = width] = context.params.dimensions.split('x');

  width = Number.parseInt(width, 10);
  height = Number.parseInt(height, 10);

  if (Number.isNaN(width) || Number.isNaN(height) || width > 4000 || height > 4000) {
    return await context.next();
  }

  const response = await fetch(context.env.GCP_CLOUD_FUNCTION_URL, {
    body: new URLSearchParams({ height, width }),
    headers: {
      'content-type': 'application/x-www-form-urlencoded'
    },
    method: 'POST'
  });

  return new Response(await response.blob(), {
    headers: {
      'cache-control': 'public, max-age=3600',
      'content-type': 'image/jpeg'
    }
  });
}
