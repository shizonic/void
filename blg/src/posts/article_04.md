author: Anachron 
tags: LVM
title: Resizing your Volumes
published: 2019-02-07T11:02:41
template: post.tpl
issue: 4

---

## Pretext

When installing `Void` I was expecting `/` (root) to only require about `10G` of disk space.
Times change and I regulary have less than `500M` of space left on that device. 
To fight this I will reduce the size of my `/data` partition to be able to extend both `lvm-void` and `lvm-copy`. 

__IMPORTANT: You use any of these commands at your own risk!__

## List of partitions before

```text
NAME                                       MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINT
sda                                          8:0    0 465,8G  0 disk
├─sda1                                       8:1    0     1G  0 part  /boot
└─sda2                                       8:2    0 464,8G  0 part
  └─luks-1e05ddda-736a-408e-8cf0-ee37c9c8d3ee
                                           254:0    0 464,8G  0 crypt
    ├─lvm-void                             254:1    0    10G  0 lvm   /
    ├─lvm-copy                             254:2    0    10G  0 lvm   /copy
    ├─lvm-swap                             254:3    0     4G  0 lvm   [SWAP]
    └─lvm-data                             254:4    0   440G  0 lvm   /data
```

## General steps

A LVM logical volume (lv) cannot be resized when it's mounted. So we first have to umount it everywhere it was mounted.
But that is not all: Any process still accessing previously mounted paths will block a lv-resize. 

Once we've umounted our logical volumes we can perform the action we want. 

- Shrinking: First resize the file-system, then the volume (partition)
- Extending: First resize the volume (partition), then the file-system

## Shrinking the data-lv

Run a file-system check to make sure everything is ok (and if not, fix it).

```text
e2fsck -fy /dev/mapper/lvm-data
```

Resize the file-system to allow 

__IMPORTANT: Make the file-system smaller than your data require!__

*(This command ran for around 10 minutes on a fast SSD)*

```text
resize2fs /dev/mapper/lvm-data 420G
```

Now that we have resized the file-system we can reduce the logical volume size.

```text
lvreduce -L 420G /dev/mapper/lvm-data
```

We can now run tools like `lsblk` to see whether our volume did really shrink.
To make sure everything is ok we can `mount` it somewhere and run `df -h <path>` on it.

## Extending the copy-lv & root-lv

To be able to make the file-system bigger, we need to extend the volume itself.

```text
lvextend -L 20G /dev/mapper/lvm-copy
```

Run a file-system check to make sure everything is ok (and if not, fix it).

```text
e2fsck -fy /dev/mapper/lvm-copy
```

Now we can let the filesystem reclaim the rest of the space.

```text
resize2fs /dev/mapper/lvm-copy 20G
```

To do the same with my `/` (root) lv-volume I booted into `lvm-copy` which is a mirror to my `lvm-void` (root).
Then I mounted `lvm-void` and run the same commands that I executed for `lvm-copy`.

## List of partitions after

```text
NAME                                       MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINT
sda                                          8:0    0 465,8G  0 disk
├─sda1                                       8:1    0     1G  0 part  /boot
└─sda2                                       8:2    0 464,8G  0 part
  └─luks-1e05ddda-736a-408e-8cf0-ee37c9c8d3ee
                                           254:0    0 464,8G  0 crypt
    ├─lvm-void                             254:1    0    20G  0 lvm   /
    ├─lvm-copy                             254:2    0    20G  0 lvm   /copy
    ├─lvm-swap                             254:3    0     4G  0 lvm   [SWAP]
    └─lvm-data                             254:4    0   420G  0 lvm   /data
```

## Summary

`LVM` doesn't need to be scary. It can be used to dynamically adjust your partitions without having to juggle around with harddisks.
