# Docker_MailForwarder
[![](https://github.com/seiferma/Docker_MailForwarder/actions/workflows/docker-publish.yml/badge.svg?branch=main)](https://github.com/seiferma/Docker_MailForwarder/actions?query=branch%3Amain+)
[![](https://img.shields.io/github/issues/seiferma/Docker_MailForwarder.svg)](https://github.com/seiferma/Docker_MailForwarder/issues)
[![](https://img.shields.io/github/license/seiferma/Docker_MailForwarder.svg)](https://github.com/seiferma/Docker_MailForwarder/blob/main/LICENSE)

The image provides a set of scripts to create a rule-based mail forwarder using an external mail account. The image uses [fdm](https://github.com/nicm/fdm), [msmtp](https://marlam.de/msmtp/) and [goimapnotify](https://gitlab.com/shackra/goimapnotify). In order to use the image, you have to create configurations for all of these tools. Examples are given in the [examples](https://github.com/seiferma/Docker_MailForwarder/tree/main/examples) directory.

The image is available as `quay.io/seiferma/mailforwarder`. View all available tags on [quay.io](https://quay.io/repository/seiferma/mailforwarder?tab=tags).
