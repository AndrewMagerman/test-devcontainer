# Developer Preferences

## Profile

I prefer practical, keyboard-driven development with a setup that stays close to how I actually work day to day.

## Tooling

Favor:

- `zsh`
- Neovim
- `chezmoi`
- terminal-first workflows
- fast CLI tools such as `git`, `ripgrep`, `fd`, `fzf`, `tmux`, and `curl`
- a non-root development user with `sudo` when needed

## Engineering Preferences

Prefer:

- reproducible environments
- explicit configuration over hidden state
- small, understandable setup code
- minimal code and minimal configuration
- the smallest change that solves the problem

Avoid:

- unnecessary abstraction
- config sprawl
- clever bootstrap logic
- comments unless they carry real information

Treat comments as a code smell by default. If code or configuration needs a comment to be understandable, first consider whether it should be simplified instead.

## Success Criteria

A good result usually means:

- the environment rebuilds quickly
- the shell and editor feel familiar
- the setup is easy to inspect and debug
- the workflow is close enough to real working conditions to expose problems early
