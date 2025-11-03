CONTRIBUTORS
============

Thank you for contributing to framework-fedora-bootc. This file lists the primary maintainers and provides a short guide to contributing, the branching/tagging policy, and where to get help.

Maintainers
-----------
- CompPhy (org) — primary repo owners and CI maintainers

How to contribute
-----------------
1. Open an issue describing the change or bug you plan to work on.
2. Fork the repository and create a feature branch for your work (e.g., `fix/issue-123` or `feature/add-xyz`).
3. Make your changes and include tests where appropriate.
4. Open a pull request against `main` and reference the issue.
5. Address review comments and squash/fixup commits as requested.

Branch and tagging policy (summary)
-----------------------------------
- `main` — active development branch. Builds from `main` publish `latest` and (temporarily) the older release tag(s) while a release branch exists.
- `release-42` — maintenance branch used to continue producing Fedora 42 images and receive Renovate updates. Builds from this branch publish the `42` tag.
- When a release branch is no longer needed, it will be deleted and the workflow tagging behavior adjusted accordingly.

Renovate and automated updates
------------------------------
Renovate is configured to create automated dependency update PRs against `main` and `release-42` so maintenance branches continue to receive security and patch updates.

Contacts and support
--------------------
- For CI/build issues, open an issue tagged `ci` and mention @CompPhy maintainers.
- For security issues, follow the repository's security disclosure process (open a private report or email the maintainers).

License
-------
See the repository `LICENSE.md` for licensing details.

Thank you for your contributions!
