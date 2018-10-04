[![Go Report Card](https://goreportcard.com/badge/github.com/diegohce/gosecure)](https://goreportcard.com/report/github.com/diegohce/gosecure)
[![GitHub release](https://img.shields.io/github/release/diegohce/gosecure.svg)](https://github.com/diegohce/gosecure/releases/)
[![Github all releases](https://img.shields.io/github/downloads/diegohce/gosecure/total.svg)](https://github.com/diegohce/gosecure/releases/)
[![GPLv3 license](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://github.com/diegohce/gosecure/blob/master/LICENSE)
[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://github.com/diegohce/gosecure/graphs/commit-activity)
[![HitCount](http://hits.dwyl.io/diegohce/badges.svg)](http://hits.dwyl.io/diegohce/badges)

# gosecure 
Simple command line secure tunneling tool.

## Usage
```
  -cert string
    	Certificate file
  -key string
    	Key file
  -local string
    	Where to listen on this machine [ip_address]:port
  -remote string
    	Where to connect to {ip_address | hostname}:port
```

## Build

After setting Go environment values 
(running [. ./goenv.sh](https://github.com/diegohce/gosecure/blob/master/goenv.sh) might help), 
go to ```src``` directory and run from the command line:

```make```

That's it.
