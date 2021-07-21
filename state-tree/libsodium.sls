{%- set on_docker = salt['grains.get']('virtual_subtype', '') in ('Docker',) %}
{%- if grains['os'] != 'Windows' %}
  {%- if grains['os'] == 'Gentoo' %}
    {%- set libsodium = 'dev-libs/libsodium' %}
  {%- elif grains['os'] in ('SUSE', 'openSUSE') %}
    {%- set libsodium = 'libsodium-devel' %}
    {%- if not on_docker %}
      {#-
# This is a fix to the following error:
# Problem: libsodium-devel-1.0.18-lp151.78.1.x86_64 requires libsodium23 = 1.0.18, but this requirement cannot be provided
#  not installable providers: libsodium23-1.0.18-lp151.78.1.x86_64[openSUSE-Leap-cloud-tools]
# Solution 1: install libsodium23-1.0.18-lp151.78.1.x86_64 (with vendor change)
#  openSUSE  -->  obs://build.opensuse.org/devel:libraries:c_c++
# Solution 2: do not install libsodium-devel-1.0.18-lp151.78.1.x86_64
# Solution 3: break libsodium-devel-1.0.18-lp151.78.1.x86_64 by ignoring some of its dependencies

# Note that Cloud-Tools is not included in 15.2 so we commented this out
'zypper mr -d openSUSE-Leap-Cloud-Tools':
  cmd.run:
    - order: 1
    #}
    {%- endif %}
  {%- elif grains['os'] in ('Debian', 'Ubuntu') %}
    {%- set libsodium = 'libsodium-dev' %}
  {%- else %}
    {%- set libsodium = 'libsodium' %}
  {%- endif %}

  {%- if grains['os'] in ('AlmaLinux', 'CentOS', 'CentOS Stream', 'Amazon') %}
include:
  - epel
  {%- endif %}

libsodium:
  pkg.installed:
    - name: {{ libsodium }}
    - aggregate: False

{%- else %}

include:
  - python3

  {%- set python3_dir = 'c:\\\\Python38' %}
  {%- if grains['cpuarch'].lower() == 'x86' %}
    {%- set bits = 32 %}
  {%- else %}
    {%- set bits = 64 %}
  {%- endif %}

py3-libsodium:
  file.managed:
    - name: '{{ python3_dir }}\\libsodium.dll'
    - source: https://repo.saltstack.com/windows/dependencies/{{ bits }}/libsodium.dll
    - skip_verify: true
    - require:
      - python3

libsodium:
  test.succeed_without_changes:
    - require:
      - py3-libsodium
{%- endif %}
