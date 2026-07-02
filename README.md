## 📖 Foundry Docs

<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
[![All Contributors](https://img.shields.io/badge/all_contributors-115-orange.svg?style=flat-square)](#contributors-)
<!-- ALL-CONTRIBUTORS-BADGE:END -->

[![CI - Run Tests & Lint](https://github.com/davidmontgomery802-ai/book/actions/workflows/ci.yml/badge.svg?branch=master)](https://github.com/davidmontgomery802-ai/book/actions/workflows/ci.yml)
[![Deploy - Build and Deploy to Production](https://github.com/davidmontgomery802-ai/book/actions/workflows/deploy.yml/badge.svg?branch=master)](https://github.com/davidmontgomery802-ai/book/actions/workflows/deploy.yml)
[![Security - Dependency & Code Scanning](https://github.com/davidmontgomery802-ai/book/actions/workflows/security.yml/badge.svg?branch=master)](https://github.com/davidmontgomery802-ai/book/actions/workflows/security.yml)

Documentation on all things Foundry. [Read now](https://getfoundry.sh).

### Quick Links

- 📚 [Workflow Documentation](.github/README.md)
- 🚀 [View Workflows](https://github.com/davidmontgomery802-ai/book/actions)
- 📦 [Releases](https://github.com/davidmontgomery802-ai/book/releases)

### Contributing

Check our [contributing guidelines](./CONTRIBUTING.md). Feel free to contribute wording, sentences, chapters, and guides!

The book is built with [vocs](https://vocs.dev). Install dependencies with `bun install`.

To see the book change live run:

```sh
bun dev
```

To add a new section (file) to the book, add it to [`sidebar.ts`](./sidebar/sidebar.ts).

For a more structured overview of the current issues, see [the GitHub project](https://github.com/orgs/foundry-rs/projects/1).

### Development

#### Pull Request Workflow

1. Create a feature branch
2. Make your changes
3. Ensure your code builds: `bun run build`
4. Push to your branch
5. Create a Pull Request
6. Wait for CI checks to pass:
   - ✅ `test-and-lint` - Code builds and passes checks
   - ✅ Other required status checks
7. Request review from code owners
8. Merge once approved

All commits must be signed. See [GitHub documentation](https://docs.github.com/en/authentication/managing-commit-signature-verification) for setup instructions.

#### CI/CD Workflows

This repository uses automated GitHub Actions workflows:

- **CI**: Runs on every PR and push - builds, tests, and lints code
- **Deploy**: Runs on merge to master - deploys to production automatically
- **Security**: Daily automated security scanning for vulnerabilities
- **Quality**: Checks code formatting and linting on every PR

See [.github/README.md](.github/README.md) for detailed workflow documentation.

### Contributors ✨

Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tbody>
    <tr>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/ZeroEkkusu"><img src="https://avatars.githubusercontent.com/u/94782988?v=4?s=100" width="100px;" alt="Zero Ekkusu"/><br /><sub><b>Zero Ekkusu</b></sub></a><br /><a href="https://github.com/foundry-rs/book/commits?author=ZeroEkkusu" title="Documentation">📖</a></td>
      <td align="center" valign="top" width="14.28%"><a href="https://rootulp.xyz"><img src="https://avatars.githubusercontent.com/u/3699047?v=4?s=100" width="100px;" alt="Rootul Patel"/><br /><sub><b>Rootul Patel</b></sub></a><br /><a href="https://github.com/foundry-rs/book/commits?author=rootulp" title="Documentation">📖</a></td>
    </tr>
  </tbody>
</table>
