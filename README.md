[![Build Status](https://travis-ci.com/cassidyjames/ideogram.svg?branch=master)](https://travis-ci.com/cassidyjames/ideogram)

<p align="center">
  <img src="data/icons/128.svg" alt="Icon" />
</p>
<h1 align="center">Ideogram</h1>
<!--p align="center">
  <a href="https://appcenter.elementary.io/com.github.cassidyjames.ideogram"><img src="https://appcenter.elementary.io/badge.svg?new" alt="Get it on AppCenter" /></a>
</p-->

![Screenshot](data/screenshot.png?raw=true)

## Insert emoji anywhere, even in non-native apps

Quickly insert emoji anywhere you can paste text, including non-native apps. Hit ⌘+E to open the emoji picker, choose the emoji you want, and it's instantly pasted. 👍

<!--
## Made for [elementary OS](https://elementary.io)

Ideogram is designed and developed on and for [elementary OS](https://elementary.io). Purchasing through AppCenter directly supports the development and ensures instant updates straight from me. Get it on AppCenter for the best experience.

[![Get it on AppCenter](https://appcenter.elementary.io/badge.svg)](https://appcenter.elementary.io/com.github.cassidyjames.ideogram)

Versions of Ideogram may have been built and made available elsewhere by third-parties. These builds may have modifications or changes and **are not provided nor supported by me**. The only supported version is distributed via AppCenter on elementary OS.
-->

## Developing and Building

If you want to hack on and build Ideogram yourself, you'll need the following dependencies:

* libgtk-3-dev
* meson
* valac

Run `meson build` to configure the build environment and run `ninja test` to build and run automated tests

    meson build --prefix=/usr
    cd build
    ninja test

To install, use `ninja install`, then execute with `com.github.cassidyjames.ideogram`

    sudo ninja install
    com.github.cassidyjames.ideogram

-----

<!--
[![Get it on AppCenter](https://appcenter.elementary.io/badge.svg)](https://appcenter.elementary.io/com.github.cassidyjames.ideogram)
-->
