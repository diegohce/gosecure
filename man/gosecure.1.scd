gosecure(1)

# NAME

gosecure - Simple SSL tunneling tool

# SYNOPSIS

*gosecure* -cert _cert-file_ -key _key-file_  -local [ip]:port -remote {hostname | ip}:port

# DESCRIPTION

gosecure is a small tool to secure with SSL connection to applications
that do no handle SSL.

A few bash scripts helps *gosecure* to run as daemon. Edit /etc/default/gosecure to 
enable.

Use /etc/gosecure/sample.conf.sample as a template for your configuration files.


# COMMAND LINE OPTIONS

\-alpn Comma-separated list of supported application level protocols

\-cert	Certificate file

\-key		Key file

\-local	Where to listen on this machine [ip_address]:port

\-remote	Where to connect to {ip_address | hostname}:port

# CONFIG FILE VARIABLES

NAME		Instance name

LOCAL	Same as *-local*

REMOTE	Same as *-remote*

CERT		Same as *-cert*

KEY		Same as *-key*

# EXAMPLES

## COMMAND LINE

\# gosecure -min-tls 1.3 -cert example.com.crt -key example.com.key -local :443 -remote 10.0.3.25:80

## CONFIG FILE

NAME=my\_secure\_site

LOCAL=:443

REMOTE=10.0.3.25:80

CERT=example.com.crt

KEY=example.com.key

# AUTHORS

Maintained by Diego Cena <diego.cena@gmail.com>. Up-to-date sources and binaries
can be found at https://github.com/diegohce/gosecure and bugs/issues 
can be submitted there.

