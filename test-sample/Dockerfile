FROM nginx:alpine

# 1️⃣ Default nginx site hatao
RUN rm -f /etc/nginx/conf.d/default.conf

# 2️⃣ Tumhara nginx config
COPY nginx.conf /etc/nginx/conf.d/default.conf

# 3️⃣ Frontend files (HTML + CSS + JS)
COPY index.html /usr/share/nginx/html/index.html
COPY style.css /usr/share/nginx/html/style.css
COPY script.js /usr/share/nginx/html/script.js

EXPOSE 80

# 4️⃣ Nginx start
CMD ["nginx", "-g", "daemon off;"]
