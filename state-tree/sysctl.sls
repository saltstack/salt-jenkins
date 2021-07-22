{%- if grains['os'] == 'FreeBSD' %}
adjust_freebsd_kernel_values:
  file.append:
    - name: /etc/sysctl.conf
    - text:
      - "kern.ipc.maxsockbuf=16777216"
      - "kern.maxfiles=2048000"
      - "kern.maxfilesperproc=200000"
      - "net.inet.tcp.sendspace=262144"
      - "net.inet.tcp.recvspace=262144"
      - "net.inet.tcp.sendbuf_max=16777216"
      - "net.inet.tcp.recvbuf_max=16777216"
      - "net.inet.tcp.sendbuf_inc=32768"
      - "net.inet.tcp.recvbuf_inc=65536"
      - "net.local.stream.sendspace=16384"
      - "net.local.stream.recvspace=16384"
      - "net.inet.raw.maxdgram=16384"
      - "net.inet.raw.recvspace=16384"
      - "net.inet.tcp.abc_l_var=44"
      - "net.inet.tcp.initcwnd_segments=44"
      - "net.inet.tcp.mssdflt=1448"
      - "net.inet.tcp.minmss=524"
      - "vfs.read_max=128"
{%- endif %}
