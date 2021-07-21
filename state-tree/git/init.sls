{%- if grains['os_family'] == 'Debian' and grains['osmajorrelease'] == 9 %}
  {%- set git = 'git-core' %}
{%- elif grains['os'] == 'Windows' %}
  {%- set PROGRAM_FILES = "%ProgramFiles%" %}
{%- elif grains['os'] == 'Gentoo' %}
  {%- set git = 'dev-vcs/git' %}
{%- else %}
  {%- set git = 'git' %}
{%- endif %}
{%- set git_binary = 'git' | which %}

system-up-to-date:
  pkg.uptodate:
    - refresh: True

force-sync-all:
  module.run:
    - name: saltutil.sync_all
    - order: 1
    - reload_modules: True
    - require:
      - system-up-to-date

{%- if grains['os_family'] != 'Windows' %}
  {%- if grains['os_family'] == 'RedHat' %}
include:
   - python.ca-certificates
  {%- endif %}

  {%- if grains['os_family'] == 'Arch' %}
libgit2:
  pkg.installed:
    - name: libgit2
    - aggregate: False
  {%- endif %}

git:
  pkg.installed:
    - name: {{ git }}
    - aggregate: False
    - refresh: True  # Ensure that pacman runs the first time with -Syu
    {%- if grains['os_family'] == 'RedHat' %}
    - require:
      - pkg: ca-certificates
    {%- endif %}
{%- endif %}
