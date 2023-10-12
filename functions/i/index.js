/**
 * Cloudflare Pages Function
 *
 * Responds to `POST https://spaceholder.cc/i`. The incoming request must be of
 * content type `application/x-www-form-urlencoded` and include `width` and
 * `height` parameters.
 *
 * @see {@link https://developers.cloudflare.com/pages/platform/functions/api-reference/}
 *
 * @param {EventContext} context An EventContext instance.
 *
 * @returns {Response} Most likely a 302 redirect.
 */
export async function onRequestPost(context) {
  const regexp = /^application\/x-www-form-urlencoded(?:;.+)?$/;

  const { request } = context;

  console.log('Received request:', request.method, request.url);

  if (regexp.test(request.headers.get('content-type'))) {
    const body = await request.formData();
    const { width, height } = Object.fromEntries(body);

    if (width && height) {
      console.log('Generating response for request with params:', width, height);

      return new Response(null, {
        headers: {
          location: `/i/${width}x${height}`
        },
        status: 302
      });
    }
  }

  return await context.next();
}
