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
        status: 302,
        headers: {
          location: `/i/${width}x${height}`
        }
      });
    }
  }

  return await context.next();
};
