export default async (request, context) => {
  const requestId = request.headers.get('x-nf-request-id');
  const url = new URL(request.url);

  console.log(requestId, 'Received request:', request.method, request.url);

  if (url.pathname === '/i' && request.method === 'POST') {
    const regexp = /^application\/x-www-form-urlencoded(?:;.+)?$/;

    if (regexp.test(request.headers.get('content-type'))) {
      const body = await request.clone().formData();
      const params = Object.fromEntries(body);

      if (params.width && params.height) {
        console.log(requestId, 'Generating response for request with params:', params);

        return new Response(null, {
          status: 302,
          headers: {
            location: `/i/${params.width}/${params.height}`,
            'x-nf-request-id': requestId
          }
        });
      }
    }
  }

  return context.next();
};
