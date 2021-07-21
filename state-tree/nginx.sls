
{%- set os_family = salt['grains.get']('os_family', '') %}
{%- set os_major_release = salt['grains.get']('osmajorrelease', 0)|int %}
nginx:
  pkg.installed:
    - aggregate: False

{%- if os_family == 'Debian' and os_major_release != 9 %}
{#- Debian based distributions always start services #}
disable-nginx-service:
  service.disabled:
    - name: nginx
{%- endif %}
