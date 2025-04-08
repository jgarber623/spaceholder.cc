> [!IMPORTANT]
> This project has moved to [codeberg.org/jgarber/spaceholder.cc](https://codeberg.org/jgarber/spaceholder.cc).

<img src="https://repository-images.githubusercontent.com/47727289/5a63ef3c-5e9b-4d0d-ae24-fd5ba415b32b" alt="SpaceHolder">

**A space-themed image placeholder service.**

[![Deployment](https://img.shields.io/github/deployments/jgarber623/spaceholder.cc/spaceholder-cc%20%28Production%29?label=Deployment&logo=github&style=for-the-badge)](https://github.com/jgarber623/spaceholder.cc/deployments/activity_log?environment=spaceholder-cc+%28Production%29)
[![Build](https://img.shields.io/github/actions/workflow/status/jgarber623/spaceholder.cc/ci.yml?branch=main&logo=github&style=for-the-badge)](https://github.com/jgarber623/spaceholder.cc/actions/workflows/ci.yml)

## Usage

Jamming on a prototype? Cranking on buildout but you don't have content images from your client yet? Drop the following in your markup and marvel at the wonders of the universe:

```html
<img src="https://spaceholder.cc/i/400x300" alt="This is an awesome spaceholder!">
```

Replace `400x300` with whatever pixel dimensions you like: `200x50`, `1200x400`, `240x240`. You'll be traveling the outer reaches so long as the format is a number, an `x`, and another number. For sanity's sake, both dimensions may be no larger than `4000`.

If you'd like a square image, use a single number in the URL:

```html
<img src="https://spaceholder.cc/i/400" alt="This is an awesome square spaceholder!">
```

## Acknowledgments

Tip o' the hat to [Brad Frost](https://twitter.com/brad_frost) for [the inspiration](https://twitter.com/brad_frost/status/674668640915087360) and [Alex Rehberg](https://twitter.com/alex_rehberg) for [the name](https://twitter.com/alex_rehberg/status/674668731272794112). Many thanks to [Ste Grainer](https://twitter.com/stegrainer) for SpaceHolder's logo and visual design.

All those amazing photos are sourced from [ESA/Hubble](https://esahubble.org) and are released under the [Creative Commons Attribution 4.0 International license](http://creativecommons.org/licenses/by/4.0/).

SpaceHolder is written and maintained by [Jason Garber](https://sixtwothree.org).

## License

SpaceHolder is freely available under the [MIT License](https://opensource.org/licenses/MIT). Use it, learn from it, fork it, improve it, change it, tailor it to your needs.
