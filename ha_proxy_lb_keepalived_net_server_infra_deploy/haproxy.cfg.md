# HAProxy Configuration File Documentation (`haproxy.cfg`)

This document provides a detailed explanation of the `haproxy.cfg` configuration file. HAProxy is a free, open-source software that provides a high availability load balancer and proxy server for TCP and HTTP-based applications that spreads requests across multiple servers.

---

## `global` Section

The `global` section defines process-wide settings. These settings are not tied to any specific frontend or backend and affect the overall operation of the HAProxy instance.

```
global
    log /dev/log    local0
    log /dev/log    local1 notice
    chroot /var/lib/haproxy
    stats socket /run/haproxy/admin.sock mode 660 level admin expose-fd listeners
    stats timeout 30s
    user haproxy
    group haproxy
    daemon
```

### Line-by-Line Explanation

- **`log /dev/log local0` and `log /dev/log local1 notice`**
    - **What it is:** These lines configure HAProxy's logging. It sends log messages to the syslog server at `/dev/log` using two different facilities, `local0` for general logs and `local1` for notice-level messages.
    - **Why we use it:** Logging is crucial for monitoring, debugging, and security auditing. Separating log streams allows for better organization and filtering of log data.
    - **Other options:** You can log to a file directly (e.g., `log /var/log/haproxy.log`) or to a remote syslog server (e.g., `log 192.168.1.1:514 local0`). The log level can be adjusted (e.g., `info`, `debug`, `warning`, `err`).

- **`chroot /var/lib/haproxy`**
    - **What it is:** This directive changes the root directory of the HAProxy process to `/var/lib/haproxy` after it starts. 
    - **Why we use it:** This is a security measure. If the HAProxy process is compromised, the attacker's access is restricted to this directory, preventing them from accessing the rest of the filesystem.
    - **Importance:** It significantly enhances the security of the server by containing potential breaches.

- **`stats socket /run/haproxy/admin.sock mode 660 level admin expose-fd listeners`**
    - **What it is:** This creates a Unix socket for statistics and administrative tasks.
    - **Why we use it:** It allows administrators to manage HAProxy at runtime without restarting the service. You can enable/disable servers, view statistics, and more.
    - **Other options:** The `level` can be `user` (read-only) or `operator` (some changes allowed).

- **`stats timeout 30s`**
    - **What it is:** Sets the maximum inactivity time on the stats socket.
    - **Why we use it:** It prevents idle connections from holding resources on the stats socket.

- **`user haproxy` and `group haproxy`**
    - **What it is:** These lines set the user and group under which the HAProxy process will run.
    - **Why we use it:** This is another security best practice. Running HAProxy as a non-root user limits the potential damage if the process is compromised.

- **`daemon`**
    - **What it is:** This makes HAProxy run as a background process.
    - **Why we use it:** This is the standard way to run services on a server, allowing it to run without being attached to a terminal.

---

## `defaults` Section

The `defaults` section sets default parameters for all subsequent `frontend`, `backend`, and `listen` sections. This helps to avoid repetition and ensures consistency.

```
defaults
    log     global
    mode    http
    option  httplog
    option  dontlognull
    timeout connect 5000
    timeout client  50000
    timeout server  50000
```

### Line-by-Line Explanation

- **`log global`**
    - **What it is:** This specifies that all subsequent sections should use the logging configuration defined in the `global` section.

- **`mode http`**
    - **What it is:** Sets the default proxying mode to HTTP. 
    - **Why we use it:** This is for Layer 7 load balancing, which is content-aware. It allows HAProxy to inspect HTTP traffic.
    - **Other options:** `tcp` for Layer 4 load balancing (faster but not content-aware) and `health` for health checks.

- **`option httplog`**
    - **What it is:** Enables a more detailed and readable log format for HTTP requests and responses.
    - **Why we use it:** It provides valuable information like timing, status codes, and headers, which is very useful for debugging.

- **`option dontlognull`**
    - **What it is:** This option prevents logging of connections with no data transfer.
    - **Why we use it:** It reduces log noise by ignoring health checks and other connections that don't transfer actual data.

- **`timeout connect 5000`**
    - **What it is:** Sets the maximum time (in milliseconds) to wait for a connection attempt to a server to succeed.
    - **Why we use it:** It prevents HAProxy from waiting indefinitely for a non-responsive server.

- **`timeout client 50000` and `timeout server 50000`**
    - **What it is:** These set the maximum inactivity time on the client and server side, respectively.
    - **Why we use it:** They prevent connections from being held open for too long, which can exhaust resources.

---

## `frontend http_front` Section

The `frontend` section defines how HAProxy receives traffic from clients.

```
frontend http_front
    bind *:80
    stats uri /haproxy?stats
    default_backend http_back
```

### Line-by-Line Explanation

- **`bind *:80`**
    - **What it is:** This tells HAProxy to listen for incoming connections on all network interfaces on port 80 (the standard HTTP port).
    - **Why we use it:** This is the entry point for all web traffic that the load balancer will handle.

- **`stats uri /haproxy?stats`**
    - **What it is:** This enables the HAProxy statistics report page at the URI `/haproxy?stats`.
    - **Why we use it:** It provides a web-based interface to monitor the status of frontends, backends, and servers.

- **`default_backend http_back`**
    - **What it is:** This specifies that if no other rule matches, traffic from this frontend should be sent to the `http_back` backend.

---

## `backend http_back` Section

The `backend` section defines a pool of servers that will handle the requests forwarded by the frontend.

```
backend http_back
    balance roundrobin
    server web1 192.168.56.12:80 check
    server web2 192.168.56.13:80 check
```

### Line-by-Line Explanation

- **`balance roundrobin`**
    - **What it is:** This sets the load balancing algorithm to `roundrobin`. Each server is used in turn, according to its weight.
    - **Why we use it:** It's a simple and effective way to distribute traffic evenly across servers.
    - **Other options:** `static-rr` (similar to roundrobin but weights are fixed), `leastconn` (sends traffic to the server with the fewest connections), `source` (hashes the source IP to determine which server to use, providing session persistence).

- **`server web1 192.168.56.12:80 check` and `server web2 192.168.56.13:80 check`**
    - **What it is:** These lines define the backend servers. `web1` and `web2` are the names of the servers, followed by their IP addresses and the port they are listening on.
    - **`check`:** The `check` option enables health checks on these servers. HAProxy will periodically check if the servers are up and running. If a server fails the health check, it will be temporarily removed from the pool.
    - **Why we use it:** This is the core of the load balancing setup, defining where to send the traffic. Health checks are essential for high availability, ensuring that traffic is not sent to a down server.
