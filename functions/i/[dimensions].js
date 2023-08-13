export async function onRequestGet(context) {
  let [width, height = width] = context.params.dimensions.split('x');

  width = parseInt(width, 10);
  height = parseInt(height, 10);

  if (isNaN(width) || isNaN(height) || width > 4000 || height > 4000) {
    return await context.next();
  }

  const response = await fetch(context.env.GCP_CLOUD_FUNCTION_URL, {
    method: 'POST',
    headers: {
      'content-type': 'application/x-www-form-urlencoded'
    },
    body: new URLSearchParams({ width, height })
  });

  return new Response(await response.blob(), {
    headers: {
      'cache-control': 'public, max-age=3600',
      'content-type': 'image/jpeg'
    }
  });
};
