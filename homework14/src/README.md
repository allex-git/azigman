# Docker Compose + NGINX Reverse Proxy + Flask API

Цей проєкт є продовженням Homework 13.
Контейнеризуємо Flask REST API (додаток з HW13) та додаємо NGINX, який працює як reverse proxy перед Gunicorn

---

# опис

У проєкті налаштовано два сервіси:

## **1. app (Flask + Gunicorn)**  
Це бекенд-додаток з homework 12 та 13, контейнеризований у Docker.  
Запускається через Gunicorn на порту **8000** (всередині контейнера).  
Зовнішній порт не відкритий — ним керує NGINX.

## **2. nginx (reverse proxy)**  
Приймає всі HTTP-запити через порт **8080** і перенаправляє їх у контейнер `app`:

```
http://localhost:8080 → http://app:8000
```

Файл конфігурації знаходиться в:  
`nginx/default.conf`

---

# як запустити додаток

## 1. перейти в директорію проекту:

```
cd homework14
```

або у Git Bash:

```
cd /d/homework/homework14
```
---

## 2. запускаємо сервіси

```
docker compose up -d --build
```
---

## 3. перевіяємо статус

```
docker ps
```

бачимо:

```
flask_app     ... 8000/tcp
nginx_proxy   ... 0.0.0.0:8080->80/tcp
```
---

# 4. перевірка API через Postman / браузер

##  - отримати всіх студентів (GET)

**Method:** GET  
**URL:**
```
http://127.0.0.1:8080/students
```
---

## - створення студента (POST)

**Method:** POST  
**URL:**
```
http://127.0.0.1:8080/students
```

**Body → raw → JSON**
```json
{
  "first_name": "Alex",
  "last_name": "DevOps",
  "age": "39"
}
```
---

## - отримання студента за id (GET)

**URL:**
```
http://127.0.0.1:8080/students?id=1
```
---

## - отримання за прізвищем (GET)

**URL:**
```
http://127.0.0.1:8080/students?last_name=Kornilov
```
---

## - оновлення віку (PATCH)

**Method:** PATCH  
**URL:**
```
http://127.0.0.1:8080/students
```

**Body:**
```json
{
  "id": "1",
  "age": "38"
}
```
---

## - оновлення всіх полів (PUT)

**Method:** PUT  
**URL:**
```
http://127.0.0.1:8080/students
```

**Body:**
```json
{
  "id": "2",
  "first_name": "Ehor",
  "last_name": "Kornilov",
  "age": "29"
}
```
---

## - видалення (DELETE)

**Method:** DELETE  
**URL:**
```
http://127.0.0.1:8080/students
```

**Body:**
```json
{
  "id": "1"
}
```
---

## 5. автоматичне тестування

У проєкті є файл **test_requests.py**, який автоматично перевіряє роботу API.

### Запуск тестів
```bash
python test_requests.py
```

Результат буде збережено у:

```
results.txt
```
---

## 6. зміст файлу "docker-compose"

```yaml
services:
  app:
    build:
      context: .
      dockerfile: dockerfile
    container_name: flask_app
    expose:
      - "8000"
    restart: always

  nginx:
    image: nginx:latest
    container_name: nginx_proxy
    ports:
      - "8080:80"
    volumes:
      - ./nginx/default.conf:/etc/nginx/conf.d/default.conf
    depends_on:
      - app
    restart: always
```
## 7. Конфігурація Nginx (Nginx/default.conf)
```nginx
server {
    listen 80;

    location / {
        proxy_pass http://app:8000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
```
## 8. Структура проєкту

```
📁 homework14
├── 📜app.py
├── 📜test_requests.py
├── 📜results.txt 
├── 📜app.py
├── 📜docker-compose.yml
├── 📜dockerfile
├── 📜.dockerignore 
├── 📜requirements.txt
├── 📜students.csv
├── 📁nginx/
│   └── 📜default.conf
└── 📜README.md
```