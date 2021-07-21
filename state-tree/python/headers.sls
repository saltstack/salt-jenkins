{%- if grains['os_family'] in ('Arch', 'Solaris', 'FreeBSD', 'Gentoo', 'MacOS') %}
    {%- set python2_dev = False %}
    {%- set python3_dev = False %}
{%- elif grains['os'] == 'Amazon' %}
  {%- set python2_dev = 'python-devel' %}
  {%- set python3_dev = 'python3-devel' %}
{%- elif grains['os'] == 'Fedora' %}
  {%- set python3_dev = 'python3-devel' %}
  {%- if grains['osrelease']|int >=32 %}
    {%- set python2_dev = False %}
  {%- else %}
    {%- set python2_dev = 'python2-devel' %}
  {%- endif %}
{%- elif grains['os'] in ('AlmaLinux', 'CentOS', 'CentOS Stream', 'RedHat') %}
  {%- if grains['osrelease'].startswith('8') %}
    {%- set python3_dev = 'python36-devel' %}
    {%- set python2_dev = False %}
  {%- else %}
    {%- set python3_dev = 'python3-devel' %}
    {%- set python2_dev = 'python-devel' %}
  {%- endif %}
{%- elif grains['os_family'] == 'Suse' %}
  {%- set python3_dev = 'python3-devel' %}
  {%- set python2_dev = 'python-devel' %}
{%- elif grains['os_family'] == 'Debian' %}
  {%- set python3_dev = 'python3-dev' %}
  {%- if salt.grains.get('osmajorrelease')|int < 10 %}
    {%- set python2_dev = 'python-dev' %}
  {%- else %}
    {%- set python2_dev = False %}
  {%- endif %}
{%- else %}
  {%- set python3_dev = 'python3-dev' %}
  {%- set python2_dev = 'python-dev' %}
{%- endif %}

{%- if python2_dev %}
python2-dev:
  pkg.installed:
    - name: {{ python2_dev }}
    - aggregate: False
    {%- if grains['os'] in ('AlmaLinux', 'CentOS', 'CentOS Stream') and grains['osrelease'].startswith('6') %}
    - fromrepo: saltstack
    {%- endif %}
{%- endif %}

{%- if python3_dev %}
python3-dev:
  pkg.installed:
    - name: {{ python3_dev }}
    - aggregate: False
{%- endif %}

python-dev:
  {%- if not python2_dev and not python3_dev %}
  test.succeed_without_changes
  {%- else %}
  test.succeed_without_changes:
    - require:
      {%- if python2_dev %}
      - python2-dev
      {%- endif %}
      {%- if python3_dev %}
      - python3-dev
      {%- endif %}
  {%- endif %}
