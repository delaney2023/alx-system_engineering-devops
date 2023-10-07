#!/usr/bin/env bash
## Installs Nginx with puppet with the following configurations:
#+    Listens on port 80.
#+    Returns a page containing "Hello World!" when queried
#+     at the root with a curl GET request.
#+    Configures /redirect_me as a "301 Moved Permanently".
#+    Includes a custom 404 page containing "Ceci n'est pas une page".
#+    Contains a custom HTTP header named X-Served-By.
#+    The value of the HTTP header is the hostname of the running server.

package { 'nginx':
  ensure => installed,
}
