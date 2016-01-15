server {
    server_name jira.icekernel.com www.jira.icekernel.com;
    listen 80;

    access_log /var/log/nginx/jira_access.log;
    error_log /var/log/nginx/jira_error.log;

    location / {
      proxy_pass http://127.0.0.1:8080;
      proxy_set_header Host $host;
      proxy_set_header X-Real-IP $remote_addr;
      proxy_set_header X-Forwarded-for $remote_addr;
      port_in_redirect off;
      proxy_redirect http://127.0.0.1:8080/ /;
      proxy_connect_timeout 600;
    }
  }
