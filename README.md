# Production and Logistics Systems

The [HTWK Leipzig Production and Logistics Systems](https://fing.htwk-leipzig.de/forschung-transfer/produktions-und-logistiksysteme) group's Jekyll site, published at <https://htwk-prodlog.github.io/>.

## Local preview

Install Ruby (3.4 in CI), its development headers (`ruby-dev` on Debian/Ubuntu), and Bundler, then run from the repository root:

```sh
bundle install
bundle exec jekyll serve --livereload
```

Open <http://127.0.0.1:4000/>. The build fetches the organization's public GitHub repositories; no API key is needed for ordinary local use. If you hit GitHub's anonymous API rate limit, set `GITHUB_TOKEN` in your shell before starting Jekyll. Stop the server with Ctrl+C.

If Bundler or the Ruby development headers are unavailable locally, use Docker instead:

```sh
docker run --rm -p 4000:4000 -v "$PWD":/site -v htwk-prodlog-bundle:/bundle \
  -w /site -e BUNDLE_PATH=/bundle ruby:3.4 \
  sh -lc 'bundle install && bundle exec jekyll serve --host 0.0.0.0'
```

Open the same local URL. Jekyll rebuilds when files change; refresh the browser to see updates. The named volume caches installed gems between runs.

For a production build and local link check, run `bash tools/test.sh`.

## Projects and deployment

At build time, `_plugins/projects.rb` lists all public repositories in `htwk-prodlog`, including paginated results. It shows repositories with GitHub Pages enabled (`has_pages`), excluding this site repository. The gallery links to each project's Pages URL and repository; it does not need client-side API access. The GitHub Pages workflow builds and deploys on pushes to `main` or `master`, on manual dispatch, and nightly to pick up newly published projects without a commit. Enable **GitHub Actions** as the Pages build source in the repository settings.

The site uses Chirpy's German locale (`de-DE`). Gallery descriptions come directly from each repository's GitHub description, in whichever language its maintainers use; repositories without one get a generic German fallback. The language icon in the sidebar opens an optional, automatically translated English view through Google Translate. Browsers can also translate the German pages directly. There is no separately maintained English copy.
