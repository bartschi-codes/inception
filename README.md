# 🐳 Inception
### A System Administration Project
---

## 📝 Overview

A small web-stack created form scratch using Docker and docker-compose. No prebuild images and based an alpine. 

- **Proxy**         NGINX  
- **Frontend**      Wordpress + php-fpm
- **Database**      MariaDB
- **Overview**      Node exporter and Prometheus
- **Redis**         Redis
- **Admin Access**  Adminer

---



## 🚀 How to Run

clone and make
```bash
git clone https://github.com/bartschi-codes/inception.git
cd inception
make

```
access wordpress via ``` localhost:443 ```

Example Logins are set in ``` src/.env ```

---

## 👨‍💻 Authors

- [@bartschi-code](https://github.com/bartschi-code)
