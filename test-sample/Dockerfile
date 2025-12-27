FROM nginx:alpine

# Default nginx config hatao (safe & recommended)
RUN rm /etc/nginx/conf.d/default.conf

# Tumhara wahi nginx config
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Sab files copy karo (html + css + js)
COPY . /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
