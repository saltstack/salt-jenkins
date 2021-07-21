man:
  pkg.installed:
    - aggregate: False
    {%- if grains.os_family == 'Suse' %}
    - name: man
    {%- else %}
    - name: man-db
    {%- endif %}
