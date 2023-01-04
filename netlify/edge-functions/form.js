export default async (request, context) => {
  let url = new URL(request.url);

  if (request.method === 'POST' && request.headers.get('content-type') === 'application/x-www-form-urlencoded') {
    let body = await request.clone().formData();
    let params = Object.fromEntries(body)

    if (params.width && params.height) {
      return new Response(null, {
        status: 302,
        headers: {
          location: `/i/${params.width}/${params.height}`
        }
      });
    }
  }

  return new Response(null, {
    status: 301,
    headers: {
      location: '/'
    }
  });
};
