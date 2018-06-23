author: Anachron
tags: void,setup,wm,lvm,luks
title: My setup
published: 20180623-130000
template: post.tpl
issue: 2

---

## Setup

### File-System

```
NAME                                          MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINT
sda                                             8:0    0 465,8G  0 disk
|-sda1                                          8:1    0     1G  0 part  /boot
|-sda2                                          8:2    0 464,8G  0 part
  |-luks-1e05ddda-736a-408e-8cf0-ee37c9c8d3ee 254:0    0 464,8G  0 crypt
    |-lvm-void                                254:1    0    10G  0 lvm   /
    |-lvm-copy                                254:2    0    10G  0 lvm   /copy
    |-lvm-swap                                254:3    0     4G  0 lvm   [SWAP]
    |-lvm-data                                254:4    0 440,8G  0 lvm   /data
```

### Explanation

I use two partitions `sda1` and `sda2`. While `sda1` is `/boot`-only, everything else is on `sda2`.

`sda2` is then encrypted via `luks` which has `lvm` inside. 

- `/ (root)` is on `lvm-void`.
- `/ (root-copy)` is on `lvm-copy`.
- `[SWAP]` is on `lvm-swap` &
- `/data` is on `lvm-data`.

`/home` is on `/data`. 

This way I can easily sync my system files (residing on `lvm-void`) to it's backup place (`lvm-copy`).

Since all the data is on it's own partition there is no trouble when I have to restore a backup from `lvm-copy` since `/home` is not affected.

### Backup

My backups are split into three different categories:

- **System** (Everything system-dependent, like `/etc`, `/usr`, `/root` and `/var`)
- **User** (User related files such as configurations, programdata and documents)
- **Media** (User related media-files such as audio, pictures, movies and alike)

#### System

This backup includes a copy of `/boot`, all files/dirs listed above, luks-headers, the lvm-config, a void package list and a backup of block devices and their ids.

#### User

A user backup typically includes all app files (configs and data), user-specific binaries/programs and all documents/downloads/mails/etc.

### Media

Every other data-type, mostly big-data, is included in this backup. Files like pictures, songs, movies and alike will be backed up to this place. This backup normally takes the longest amount of time.
