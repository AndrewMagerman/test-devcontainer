# Project Brief

## Purpose

This project exists to build a test devcontainer that mimics the way I am expected to work for a customer on a managed MacBook Pro.

The goal is not a generic sample container. The goal is a realistic, repeatable dry run on my local machine so I can familiarize myself with the new way of working before depending on it in the customer environment.

## Real-World Scenario

The target working model is:

- a customer-managed MacBook Pro as the host machine
- development performed inside devcontainers
- Colima used on the host to provide the container VM/runtime
- Ghostty used on the macOS host as the terminal
- connecting from the host into a running devcontainer for day-to-day tooling and development work

This repository is specifically for the test devcontainer used to simulate that arrangement locally.

## Current Project Direction

The container is currently centered around:

- a Debian Bookworm base image
- a non-root `dev` user
- `zsh` as the default shell
- Neovim installed in the image
- common CLI tooling installed up front
- `chezmoi`-driven dotfile application during setup
- language and build tools needed for general development work

This should continue to evolve toward a stronger simulation of the real work setup, especially around editor support, language tooling, and the host-to-container workflow.

## Tooling Goals

The environment should support the tooling I actually want to use while working:

- Neovim `0.12`
- LSP support for Python development
- LSP support for Java development
- the ability to start and work on Spring Boot projects with Maven
- a shell and terminal workflow that feels natural from Ghostty on the host into the devcontainer

This project is also an opportunity to upgrade my Neovim setup to `0.12` while validating that it works well in the container-based workflow.

## Configuration Sources

This repository is only one part of the full setup. Relevant configuration also exists outside this repository, especially:

- my Neovim configuration under `~/.config/nvim`
- my dotfiles managed through `chezmoi`

Changes in this repository should account for the fact that the final working experience depends on how those configurations behave inside the devcontainer.

## What This Project Should Optimize For

Prioritize:

- reproducibility
- fast rebuilds
- clear setup steps
- parity with the work environment where it matters
- developer experience inside the container

Treat shell behavior, editor setup, PATH management, user permissions, bootstrap scripts, and host-to-container ergonomics as first-class concerns.

## Practical Expectations

When making changes in this repository:

- preserve the idea that the container should feel like a real daily-driver environment
- prefer explicit setup over magic
- prefer minimal solutions over feature-heavy ones
- keep the bootstrap process understandable
- reduce surprises during first run and rebuilds
- watch for anything that would behave differently in a work-like environment
- think about the full workflow, not just whether the image builds
- write as little code and configuration as possible
- avoid comments unless they are strictly necessary

## Devcontainer-Specific Guidance

Changes should generally support one or more of these outcomes:

- better parity with the managed-workstation plus devcontainer model
- more reliable editor and shell initialization
- cleaner installation of required tools
- fewer manual steps after container creation
- easier debugging when setup fails
- better support for Python, Java, and Spring Boot development inside the container
- smoother use of Neovim from the devcontainer context

If there is a tradeoff between a minimal demo and a realistic work simulation, prefer the realistic simulation unless it creates unnecessary fragility.

If there is a tradeoff between a clever solution and a small explicit solution, prefer the small explicit solution.

## Non-Goals

This project is not primarily about:

- producing a polished public template
- optimizing for the smallest possible image at all costs
- abstracting every setup detail behind complex scripts
- treating the host machine as the main development environment

Clarity and fidelity matter more than premature generalization.

## Definition Of Done

Work on this project is moving in the right direction when:

- the container builds reliably
- setup scripts run with minimal manual intervention
- shell and dotfiles initialize as expected
- Neovim `0.12` is available and behaves correctly
- Python and Java LSP workflows are usable
- Spring Boot projects can be started with Maven
- the host-plus-devcontainer workflow feels close to the expected customer setup
- the environment meaningfully resembles the conditions I want to test for work
