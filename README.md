# Emacs config

Emacs 30.2 configuration with Meow, SLY, Eglot, and Org.

## Install

Clone into your Emacs configuration directory:

```sh
git clone git@github.com:luciusmagn/emacs-config.git ~/.emacs.d
```

Start Emacs to install packages from GNU ELPA and MELPA.

## Dependencies

- Font: ProFontExtended at 9 pt.
- Common Lisp: SBCL at `/usr/local/bin/sbcl` or on `PATH`.
- Rust: `rust-analyzer` and `rustfmt`. Tree-sitter is optional, with `rust-mode` as the fallback.
- Project searches: `ripgrep`, with `grep` as the fallback.
