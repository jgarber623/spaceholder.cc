export default async (request, context) => {
  let url = new URL(request.url);

  if (url.pathname === '/i' && request.method === 'POST') {
    let regexp = new RegExp(/^application\/x-www-form-urlencoded(?:;.+)?$/);

    if (regexp.test(request.headers.get('content-type'))) {
      let body = await request.clone().formData();
      let params = Object.fromEntries(body);

      if (params.width && params.height) {
        return new Response(null, {
          status: 302,
          headers: {
            location: `/i/${params.width}/${params.height}`
          }
        });
      }
    }
  }

  return context.next();
};
