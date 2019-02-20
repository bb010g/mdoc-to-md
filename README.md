# mdoc-to-md

mdoc-to-md converts manual pages written in mdoc to GitHub Flavored Markdown so
you can drop them into your READMEs.

As mandoc isn't commonly installed outside of BSDs, this project uses the
[Nix package manager](https://nixos.org/nix/) to ensure a compatible version of
mandoc is available easily, without the fear of collision with your current man.
Nix is also used to install some CPAN packages nicely. To install Nix, either
use the [upstream installer](https://nixos.org/nix/download.html) or install a
package on [Arch (AUR)](https://aur.archlinux.org/packages/nix/),
[Fedora (COPR, currently out of date)](https://copr.fedorainfracloud.org/coprs/petersen/nix/),
[Gentoo](https://packages.gentoo.org/packages/sys-apps/nix), or
[Void Linux](https://github.com/void-linux/void-packages/tree/master/srcpkgs/nix).
The Makefile here uses Nix to build this README, so feel free to use it as an
example for your own projects.

mdoc-to-md is dual licensed under the Apache License 2.0 and MIT Licenses, at
your discretion.

# MDOC-TO-MD(1)


## NAME

`mdoc-to-md` —
mdoc to GitHub Flavored Markdown converter

## SYNOPSIS

<table>
  <tr>
    <td><code>mdoc-to-md</code></td>
    <td>[<code>-p</code> |
      <code>--processed</code>]
      [(<code>-x</code> |
      <code>--manopt</code>)
      <var>option</var>]
      [<var>FILE</var>]</td>
  </tr>
</table>

## DESCRIPTION

`mdoc-to-md` takes a manual page using
  **mdoc(7)** macros and produces a Markdown version
  suitable for dropping in GitHub README.md files.

With no <var>FILE</var>, or when
  <var>FILE</var> is -, standard input is used.
<dl>
  <dt><code>-p</code>,
    <code>--processed</code></dt>
  <dd>Use an existing HTML document produced by ‘<code>mandoc
      -T html</code>’ instead of raw mdoc.</dd>
  <dt><code>-x</code>
    <var>option</var>,
    <code>--manopt</code>
    <var>option</var></dt>
  <dd>Pass <var>option</var> as an option to
      <b>mandoc(1)</b> invocations. If you want to pass an
      option that takes an argument, you must specify it twice. For example, to
      specify the OS, use ‘<code>-x -I -x
      os=MY_OS</code>’.</dd>
</dl>

## ENVIRONMENT

<dl>
  <dt><code>MANDOC</code></dt>
  <dd>The alternate <b>mandoc(1)</b> executable to be used
      when producing HTML.</dd>
</dl>

## EXIT STATUS

The `mdoc-to-md` utility exits 0 on
  success, and &gt;0 if an error occurs.

## EXAMPLES

The following command is used to format this manual page.

```
$ mdoc-to-md -x -I -x os=$VERSION
  mdoc-to-md.1
```


## BUGS

The current processing method uses heuristics specific to mandoc's HTML output,
  and doesn't properly escape Markdown characters in the output. A better tool
  would take an arbitrary HTML &lt;body&gt;, reduce it to proper Markdown style,
  and then run any extra heuristics on top. A better tool would probably also
  not be written in Perl 5.

If anything blocks you, let me know on GitHub or email me.

## SEE ALSO

**mdoc(7)**, **mandoc(1)**,
  [GitHub Flavored Markdown Spec](https://github.github.com/gfm/)

## AUTHORS

bb010g
  &lt;[me@bb010g.com](mailto:me@bb010g.com)&gt;

The latest sources, full contributor list, and more can be found at
  [https://github.com/bb010g/mdoc-to-md](https://github.com/bb010g/mdoc-to-md).
<table>
  <tr>
    <td>September 1, 2018</td>
    <td>1.0.0</td>
  </tr>
</table>
