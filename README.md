# Emacs config

Emacs 30.2 configuration for a ThinkPad X1 Nano running NetBSD. Meow modal editing, Common Lisp with SLY, Rust with Eglot, and Org.

## Install

Clone into your Emacs configuration directory, after moving any existing configuration aside:

```sh
git clone git@github.com:luciusmagn/emacs-config.git ~/.emacs.d
```

Start Emacs with network access for the first run. Packages are installed from GNU ELPA and MELPA. Package versions are unpinned.

The configured font is ProFontExtended at 9 pt. For Common Lisp, install SBCL at `/usr/local/bin/sbcl` or on `PATH`. For Rust, install `rust-analyzer` and `rustfmt`; tree-sitter support is optional, with `rust-mode` as the fallback. Install `ripgrep` for project searches, or use the grep fallback.

## Files

- `early-init.el`: startup and initial frame settings.
- `init.el`: packages, completion, language modes, Org and terminal setup.
- `meow-config.el`: Meow bindings and editing commands.
- `cl-highlight.el`: custom Common Lisp font-lock rules and palette.
- `themes/`: Acme and Kanagawa Dragon. Press F9 to switch.

`C-l` opens a SLY REPL below the current window and submits the nearest project `.slyrc.lisp`, if present. `C-c t` opens Eat. The Meow leader is SPC; see `meow-config.el` for bindings.

## Common Lisp highlighting

Serapeum function type declarations receive separate faces for the `->` operator, declared function name, lambda-list markers, type constructors and type atoms. Bare operators, package-qualified operators and local package nicknames are supported:

```common-lisp
(-> greet (string &optional integer) string)
(serapeum:-> load-name (pathname) (values string boolean))
(sera:-> names ((vector string)) list)
```

Customize `luk/cl-highlight-style-alist` to change the palette.

Run the font-lock checks without installing packages:

```sh
emacs -Q --batch -l tests/cl-highlight-test.el -f ert-run-tests-batch-and-exit
```

## Theme credits

`themes/acme-theme.el` is by Ian Yi-En Pan, derived from John Louis Del Rosario's Plan 9 theme, and licensed under GPL-3.0-or-later. Its notices are preserved; the license text is in `licenses/acme-GPL-3.0.txt`.

`themes/kanagawa-dragon-theme.el` is a plain Emacs adaptation of the workstation's Doom configuration, based on the Kanagawa Dragon color scheme.
