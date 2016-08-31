# Introduction

This Docker project contains several docker images for building `tmux` for
CentOS/RedHat.

# Docker container

## Building Docker image

To build a Docker image run the following command:

```
sudo docker build -f Dockerfile.centos6 -t tmux-centos-6 .
```

You should give proper parameters for `-f` and `-t` options.

## Running container

To compile a proper `tmux` run the built container like this:

```
sudo docker run -v $PWD/temp:/tar-folder tmux-centos-6 [LIB_EVENT_VERSION TMUX_VERSION]
```

where:

*   `LIB_EVENT_VERSION` is an *optional* version number for `libevent`library. Default value is 2.0.22.
*  `TMUX_VERSION` is an *optional* version number for `tmux`. Default value is 2.2.

So, if you are happy with the default values then the container can be simply run like this:

```
sudo docker run -v $PWD/temp:/tar-folder tmux-centos-6
```

**Notice** `-v` option. The image requires a data volume named `/tar-folder` and it must be given when the container is run. Otherwise, the built tar.gz package cannot be copied to its destination folder.

# Installing tmux

To install `tmux` on the target machine simply copy the tar.gz package to the target machine and extract the tar.gz to root (/). For example:

```
sudo tar -xzvf tmux-centos-6.tar.gz -C /
```

The above command extracts necessary files to correct locations.
