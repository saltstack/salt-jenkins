{%- if grains['os'] == 'Windows' %}
  {%- if grains['cpuarch'].lower() == 'x86' %}
    {%- set python2 = 'python2_x86' %}
  {%- else %}
    {%- set python2 = 'python2_x64' %}
  {%- endif %}
{%- elif grains['os'] == 'openSUSE' %}
  {%- set python2 = 'python' %}
{%- elif grains['os'] in ('AlmaLinux', 'CentOS', 'CentOS Stream', 'RedHat', 'Amazon') %}
  {%- if grains['osrelease'].startswith('6') %}
    {%- set python2 = 'python27' %}
  {%- elif grains['osrelease'].startswith('2018') %}
    {#- Amazon Linux 1 #}
    {%- set python2 = 'python27' %}
  {%- else %}
    {%- set python2 = 'python' %}
  {%- endif %}
{%- elif grains['os'] in ('Ubuntu', 'Debian') %}
  {%- if grains['osrelease'] == '10' %}
    {%- set python2 = False %}
  {%- else %}
    {%- set python2 = 'python2.7' %}
  {%- endif %}
{%- elif grains['os'] == 'Fedora' %}
  {%- set python2 = 'python2' %}
{%- elif grains['os_family'] == 'Arch' %}
  {%- set python2 = 'python2' %}
{%- else %}
  {%- set python2 = 'python' %}
{%- endif %}

{%- if grains['os_family'] == 'Debian' and python2 %}
include:
  - python-apt
{%- endif %}

{%- if grains['os'] == 'MacOS' %}
python2:
  file.managed:
    - source: https://www.python.org/ftp/python/2.7.17/python-2.7.17-macosx10.6.pkg
    - name: /tmp/python-2.7.pkg
    - user: vagrant
    - group: wheel
    - skip_verify: True
    - onlyif: '[ ! -d /Library/Frameworks/Python.framework/Versions/2.7 ]'
  macpackage.installed:
    - name: /tmp/python-2.7.pkg
    - reload_modules: True
    - onlyif: '[ ! -d /Library/Frameworks/Python.framework/Versions/2.7 ]'

install-certs-py2:
  cmd.run:
    - name: /Applications/Python\ 2.7/Install\ Certificates.command
    - runas: vagrant

add-python2-to-path:
  file.append:
    - names:
      - /etc/paths.d/python:
        - text: '/Library/Frameworks/Python.framework/Versions/2.7/bin'
  environ.setenv:
    - name: PATH
    - value: '/Library/Frameworks/Python.framework/Versions/2.7/bin:{{ salt.cmd.run_stdout("echo $PATH", python_shell=True).strip() }}'
    - update_minion: True

{%- elif python2 %}

python2:
    {%- if grains['os'] != 'Windows' %}
  pkg.latest:
    {%- else %}
  pkg.installed:
    {%- endif %}
    - name: {{ python2 }}
    {%- if grains['os'] != 'Windows' %}
    - aggregate: False
    {%- else %}
    - aggregate: False
    - version: '2.7.15150'
    - extra_install_flags: "ADDLOCAL=DefaultFeature,SharedCRT,Extensions,pip_feature,PrependPath TargetDir=C:\\Python27"
    {%- endif %}

{%- else %}

python2:
  test.succeed_without_changes
{%- endif %}
