# munkibuilds.org

This repo hosts the configuration files for [munkibuilds.org](https://munkibuilds.org), a Jenkins job and Apache-served website that makes available automatic builds of [Munki](https://code.google.com/p/munki).

The (messy, I know) configuration files are organized in the following folders:

  - `apache_vhost`: The Apache VirtualHost configuration that also defines the fancy directory listing
  - `jenkins`: The Jenkins job configuration file
  - `www_root`: Various HTML resources used for templating the jobs site
