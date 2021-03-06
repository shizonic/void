author: Anachron
tags: wm, shell, status, screen, editor, media, files, dirs 
title: Diving into the Void
published: 2018-08-24T12:00:00
template: post.tpl
issue: 3

---

# Diving into the Void

## The WM, StatusBar, Shell and Editor

### Window-Manager

After fiddling around with `i3wm`, `bspwm` and `wmutils` I've now come to my new favorite WM: `cwm`.

`cwm` is not only portable and very well written but also very fast. 
It allows you to use the mouse and keyboard for window moving/resizing/selecting and can be configured via a rc-file.

In my personal testing and daily working with the WM I've come to the conclusion that `cwm` is what I've always wanted.
`cwm` supports window groups, easy key binding, reloading via `HUP` signal and very fast execution whatever you command.

### Status-Bar

I've come to the conclusion that the less you clutter your statusbar with, the more productive you are. 
This concept you can also find in my `$SHELL`, `$EDITOR` and `$IRC` setups respectively.

For my statusbar I use `lemonbar`. I've written a ton of scripts to monitor important system events/statistics.
Whenever something urgent is up, my lemonbar will display a symbol on the desktop indicating something being urgent.
Normally when nothing is up my statusbar is empty.

The following screenshot includes both the information that my sound is muted and that I have an outgoing ssh session open.

![Statusbar-Example](assets/article03_statusbar.png)

### Shell

I'm still on `bash` but rewrote most of my scripts to be `posix` compatible.
`mksh` is my destination, will need a bit more testing though.

My `$SHELL`-prompt tries to be both minimal and functional. The prompt will show me:

* The current working directory (`$PWD`)
* The git branch and if it has any non-commited changes
* Return code of the last run command (`$?`), if not 0
* Amount of jobs in the background, if any
* Amount of .env-variables that are injected into the env, if any

When the prompt gets too long (>= 30 chars) the user input will be asked in a new line.

The following image contains a few examples of my shell prompt.

* The first prompt is minimal display
* The second prompt is minimal with truncated path (auto for long paths) + git status
* The third prompt shows how rc = 0 is being ignored
* The fourth prompt shows how rc > 0 are being displayed
* The fith prompt shows how to display background jobs active in current `tty`.

![Shell-Example](assets/article03_shell.png)

### Editor

My default `$EDITOR` is vim and I haven't customized it much. 
Since I am learning `rust` I have installed `RLS` (Rust Language Server) and that's it.

![Editor-Example](assets/article03_editor.png)

## IRC, Mail, Browsing and Gaming

### IRC

I am using self-written wrappers around [ii](https://tools.suckless.org/ii/).
The setup includes a read-panel, write-panel and nicklist. Bound together by tmux.

### Mail

Totally digging the mimalism, I've come to setup my mail as the following:

- [mblaze](https://github.com/chneukirchen/mblaze) for mail composing/searching/filtering
- [getmail](http://pyropus.ca/software/getmail/) for mail retrieval and
- [msmtp](https://marlam.de/msmtp/) for mail sending.  

### Browsing

I'm boring and until [qutebrowser](https://www.qutebrowser.org/) has [plugins](https://github.com/qutebrowser/qutebrowser/issues/30) I will stick to [firefox](https://www.mozilla.org/en-US/firefox/new/).

### Gaming

There are not many games left that I play, so here is the complete list:

- [hedgewars](https://hedgewars.org)
- [DotA2](http://www.dota2.com/play/) 
- [n++](http://www.metanetsoftware.com/games/nplusplus)
- [Wc3](https://us.shop.battle.net/en-us/product/warcraft-iii-reign-of-chaos) 

## Media and Folders

I'm playing music or videos via [mpv](https://mpv.io/). The best player there is.
Streams and alike are also viewable through it.

I have the following directory tree:

```
/home/anon
├── app
├── bin
├── usr
├── vos
└── vrt

5 directories, 0 files 
```

App contains all the `cnf` (configs), `dat` (data) and `log` (logs).
For everything that needs to be secure and cannot reside in `cnf` (like ssh-keys, passwords, API-keys, etc),
there is `sec` (secure).

```
/home/anon/app
├── cnf
├── dat
├── log
└── sec

4 directories, 0 files
```

Inside the `usr` (user-related) folder are:

```
/home/anon/usr
├── cal
├── crd
├── doc
├── dsk
├── irc
├── med
├── mls
├── prj
├── pub
└── tmp

10 directories
```

`cal` (calendars), `crd` (cards), `doc` (documents), `dsk` (desktop), `irc` (irc-data), 
`med` (media likes `aud` (audio), `img` (images) etc), `mls` (mails), `prj` (projects),
`pub` (public files) and `tmp` (temporary files like `dls` (downloads))

# Screenshots/Workflow

![Photo-Roll-Screenshot](https://i.imgur.com/hBF4m5Y.png)

__Hint__: The themes are generated by wallpaper colors.
