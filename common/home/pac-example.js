// https://en.wikipedia.org/wiki/Proxy_auto-config
// https://developer.mozilla.org/en-US/docs/Web/HTTP/Guides/Proxy_servers_and_tunneling/Proxy_Auto-Configuration_PAC_file
// https://www.chromium.org/developers/design-documents/network-settings/
// https://nowhere.dk/2021/02/using-proxy-pac-with-chrome-and-derivatives-and-linux/

// can be forwarded: autossh -M 0 slow-host -L 127.0.0.1:2345:127.0.0.1:9050 -L 127.0.0.1:1234:127.0.0.1:8888
const HTTP_SLOW_HOST = 'PROXY 127.0.0.1:1234';
const TOR_SLOW_HOST = 'SOCKS5 127.0.0.1:2345';

const SOCKS5_FAST_HOST = 'SOCKS5 127.0.0.1:6789';
const HTTP_FAST_HOST = 'PROXY 127.0.0.1:9876';

const TOR_LOCAL = 'SOCKS5 127.0.0.1:9050';

// https://www.cloudflare.com/ips-v4
// https://www.cloudflare.com/ips-v6
const CLOUDFLARE = [
  ["173.245.48.0", "173.245.63.255"],
  ["103.21.244.0", "103.21.247.255"],
  ["103.22.200.0", "103.22.203.255"],
  ["103.31.4.0", "103.31.7.255"],
  ["141.101.64.0", "141.101.127.255"],
  ["108.162.192.0", "108.162.255.255"],
  ["190.93.240.0", "190.93.255.255"],
  ["188.114.96.0", "188.114.111.255"],
  ["197.234.240.0", "197.234.243.255"],
  ["198.41.128.0", "198.41.255.255"],
  ["162.158.0.0", "162.159.255.255"],
  ["104.16.0.0", "104.23.255.255"],
  ["104.24.0.0", "104.27.255.255"],
  ["172.64.0.0", "172.71.255.255"],
  ["131.0.72.0", "131.0.75.255"],
  ["2400:cb00::", "2400:cb00:ffff:ffff:ffff:ffff:ffff:ffff"],
  ["2606:4700::", "2606:4700:ffff:ffff:ffff:ffff:ffff:ffff"],
  ["2803:f800::", "2803:f800:ffff:ffff:ffff:ffff:ffff:ffff"],
  ["2405:b500::", "2405:b500:ffff:ffff:ffff:ffff:ffff:ffff"],
  ["2405:8100::", "2405:8100:ffff:ffff:ffff:ffff:ffff:ffff"],
  ["2a06:98c0::", "2a06:98c7:ffff:ffff:ffff:ffff:ffff:ffff"],
  ["2c0f:f248::", "2c0f:f248:ffff:ffff:ffff:ffff:ffff:ffff"],
];

const DEFENSIVE = [
  'googlevideo.com',
  'krebsonsecurity.com',
  'reddit.com',
  'youtu.be',
  'youtube.com',
];

function FindProxyForURL(url, host) {
  if (shExpMatch(host, '*.rs')) {
    return 'DIRECT';
  }

  for (const i of DEFENSIVE) {
    if (shExpMatch(host, `*.${i}`) || shExpMatch(host, i)) {
      return HTTP_SLOW_HOST;
    }
  }

  for (const [start, end] of CLOUDFLARE) {
    if (isInNet(host, start, end)) {
      return HTTP_SLOW_HOST;
    }
  }

  return `${SOCKS5_FAST_HOST}; ${HTTP_FAST_HOST}; ${TOR_LOCAL}; ${TOR_SLOW_HOST}`;
}

/*
https://github.com/erebe/wstunnel

Not recommended using behind reversed proxy. It might work well for non-media requests. HTTP/2 doesn't work.

wstunnel client --local-to-remote=socks5://127.0.0.1:9999 --http-upgrade-path-prefix=long-secret --dns-resolver-prefer-ipv4 --dns-resolver=dns://127.0.0.1 wss://fast-host-public-ip

wstunnel server --no-color=true --log-lvl=OFF --dns-resolver-prefer-ipv4 --dns-resolver=dns+https://1.1.1.1?sni=cloudflare-dns.com --remote-to-local-server-idle-timeout=8760h ws://127.0.0.1:9999

/etc/nginx/http.d/wstunnel.conf
server {
  listen 443 ssl reuseport default_server ipv6only=off backlog=1024;
  listen [::]:443 ssl reuseport default_server ipv6only=off backlog=1024;
  http2 on;

  ssl_certificate /etc/nginx/ssl/selfsigned/example.com.crt;
  ssl_certificate_key /etc/nginx/ssl/selfsigned/example.com.key;

  location /long-secret {
    access_log off;
    error_log /dev/null;

    include /etc/nginx/allowlist.conf;

    proxy_http_version 1.1;
    proxy_connect_timeout 60s;
    proxy_socket_keepalive on;
    proxy_send_timeout 365d;
    proxy_read_timeout 365d;

    proxy_request_buffering off;
    proxy_buffering off;
    send_timeout 0;

    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection "upgrade";

    proxy_pass http://localhost:9999/;
  }
}
*/
