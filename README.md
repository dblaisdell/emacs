Emacs configuration

To use this repository clone the repo into your ~/.emacs.d directory.

This script will read proxy.el looking for information in the following format.
```
(setq url-proxy-services '(("http" . "proxy.host.org:8080")
			   ("https" . "proxy.host.org:8080")))
```