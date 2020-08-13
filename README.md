[![Build Status](https://travis-ci.com/cassidyjames/ideogram.svg?branch=master)](https://travis-ci.com/cassidyjames/ideogram)

<p align="center">
  <img src="data/icons/128.svg" alt="Icon" />
</p>
<h1 align="center">Ideogram</h1>
<p align="center">
  <a href="https://appcenter.elementary.io/com.github.cassidyjames.ideogram"><img src="https://appcenter.elementary.io/badge.svg?new" alt="Get it on AppCenter" /></a>
</p>

![Screenshot](data/screenshot.png?raw=true)

## Insert emoji anywhere, even in non-native apps

Quickly insert emoji anywhere you can paste text, including non-native apps. Hit ⌘+E to open the emoji picker, choose the emoji you want, and it's instantly pasted. 👍 Change the shortcut in System Settings → Keyboard → Shortcuts → Custom.

## About the Emoji Picker

The emoji picker that Ideogram uses is designed and provided by [GTK](https://gitlab.gnome.org/GNOME/gtk). **Anything about the emoji picker itself is outside of the scope of this app, and outside of my control.** For example, the Unicode emoji that are presented, the font used, the scrolling performance, the search, the keywords, etc. If you have issues with the emoji picker, please file them with GTK so it can be improved not just for Ideogram, but for all apps and platforms that use GTK.

Ideogram simply wraps the existing emoji picker up in a simple app that lets you summon it by a global keyboard shortcut, and then inserts the selected emoji wherever your cursor is via the clipboard.

## Made for [elementary OS](https://elementary.io)

Ideogram is designed and developed by me on and for [elementary OS](https://elementary.io). Purchasing through AppCenter directly supports the development and ensures instant updates straight from me. Get it on AppCenter for the best experience.

[![Get it on AppCenter](https://appcenter.elementary.io/badge.svg)](https://appcenter.elementary.io/com.github.cassidyjames.ideogram)

Versions of Ideogram may have been built and made available elsewhere by third-parties. These builds may have modifications or changes and **are not provided nor supported by me**. The only supported version is distributed via AppCenter on elementary OS. Similarly, building and installing Ideogram on anything other than elementary OS is unsupported—I do not have the time and resources to support other OSes and desktop environments.  

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

[![Get it on AppCenter](https://appcenter.elementary.io/badge.svg)](https://appcenter.elementary.io/com.github.cassidyjames.ideogram)
