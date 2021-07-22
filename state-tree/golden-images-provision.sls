{%- set os_family = salt['grains.get']('os_family', '') %}
{%- set os_major_release = salt['grains.get']('osmajorrelease', 0)|int %}
{%- set on_docker = salt['grains.get']('virtual_subtype', '') in ('Docker',) %}

include:
  - path
  {%- if grains['os'] == 'FreeBSD' %}
  - sysctl
  {%- endif %}
  {%- if grains['os_family'] == 'Debian' %}
  - apt
  {%- endif %}
  {%- if grains['os'] in ('AlmaLinux', 'CentOS', 'CentOS Stream', 'Amazon') %}
  - epel
  {%- endif %}
  - hosts
  {%- if grains['os'] == 'Windows' %}
  - windows
  - vim
  {%- endif %}
  {%- if grains.get('kernel') == 'Linux' %}
  - man
  - libcurl
  - ulimits
  - libxml
  - libxslt
  - libffi
    {%- if grains['os'] not in ('Amazon',) %}
  - libgit2
    {%- endif %}
  {%- endif %}
  # All VMs get docker-py so they can run unit tests
  {%- if grains['os'] in ('AlmaLinux', 'CentOS', 'CentOS Stream') and os_major_release == 7 or grains['os'] == 'Ubuntu' and os_major_release == 16 %}
  # Docker integration tests only on CentOS 7 (for now)
  - docker
  - vault
  {%- endif %}
  {%- if grains['os'] == 'Ubuntu' and os_major_release >= 17 %}
  - dpkg
  {%- endif %}
  {%- if grains['os'] not in ('Windows',) %}
    {%- if not on_docker or (on_docker and grains['os_family'] in ('Suse', 'RedHat', 'Debian')) %}
  - locale
    {%- endif %}
  - python
  - gcc
  {%- endif %}
  - libsodium
  {#- On OSX these utils are available from the system rather than the pkg manager (brew) #}
  {%- if grains['os'] not in ('MacOS', 'Windows') %}
  - patch
  - sed
  {%- endif %}
  {%- if grains['os'] not in ('MacOS', 'Windows') %}
  {%- if grains['os_family'] in ('Arch', 'Debian', 'Suse', 'RedHat') %}
  - openldap
  {%- endif %}
  - dnsutils
  - rsync
  {%- if grains['os_family'] not in ('FreeBSD',) %}
  - tar
  {%- endif %}
  - swig  {#- Swig is required to install m2crypto #}
    {%- if pillar.get('extra-swap', True) %}
  - extra-swap
    {%- endif %}
  {%- endif %}
  {%- if os_family == 'Suse' %}
  {#- Yes! openSuse ships xml as separate package #}
  - python-xml
  {%- if not grains['osrelease'].startswith('15') %}
  - python-zypp
  {%- endif %}
  - susepkgs
  {%- endif %}
  {%- if grains['os'] == 'Arch' or (grains['os'] == 'Ubuntu' and grains['osrelease'].startswith('16.')) %}
  - lxc
  {%- endif %}
  {%- if (grains['os'] not in ['Amazon', 'FreeBSD', 'Debian', 'Ubuntu', 'SUSE', 'openSUSE', 'Windows'] and not grains['osrelease'].startswith('5.')) or (grains['os'] == 'Ubuntu' and grains['osrelease'].startswith('14.')) %}
  - npm
  - bower
  {%- endif %}
  {%- if grains['os'] == 'Fedora' %}
  - gpg
  - versionlock
  - redhat-rpm-config
  {%- endif %}
  {%- if grains['os'] == 'VMware Photon OS' %}
  - gpg
  {% endif %}
  {%- if grains['os'] != 'Windows' %}
  - dmidecode
  {%- endif %}
  {%- if grains['os'] in ('MacOS', 'Debian') %}
  - openssl
  {%- endif %}
  {%- if grains['os'] != 'Windows' %}
    {%- if grains['os_family'] not in ('Arch', 'Solaris', 'FreeBSD', 'Gentoo', 'MacOS') %}
    {#- These distributions don't ship the develop headers separately #}
  - openssl-dev
    {%- endif %}
  {%- endif %}
  {%- if grains['os'] not in ('Amazon',) and os_family in ('Arch', 'RedHat', 'Debian') %}
  - nginx
  {%- endif %}
  {%- if os_family == 'Arch' %}
  - lsb_release
  {%- endif %}
  {%- if not on_docker %}
  - sssd
  {%- endif %}
  - python.nox
  - cron
  {%- if not on_docker and 'Linux' in grains.kernel %}
  - timesync
  {%- endif %}
{%- if os_family not in ('Windows', 'MacOS',)  %}
  - dhclient_conf
  - sshd_config
{%- endif %}
{%- if grains['os'] in ('AlmaLinux', 'CentOS', 'CentOS Stream', 'Amazon') %}
{#- This is to be able to run pkgbuild tests on Salt #}
  - gpg
  - rpm
  - rpm-build
  - rpm-sign
  - createrepo
  {%- if grains['os'] in ('AlmaLinux', 'CentOS', 'CentOS Stream') %}
  - mock
  {%- endif %}
{%- endif %}

{#- Make sure there's at least one state entry in the state file #}
noop-{{ sls }}:
  test.succeed_without_changes
