# REST API for Student Management (Flask + Docker)

Це застосунок, який реалізує CRUD-операції для керування студентами.
Дані зберігаються у файлі **students.csv**, а API написаний на **Flask** та контейнеризований у **Docker**.

Кожен студент має такі поля:

- `id`
- `first_name`
- `last_name`
- `age`

---
## 1. Встановлення (локальний запуск)

###  -  створити та активувати віртуальне середовище
```bash
python -m venv venv
venv\Scripts\activate      # Windows
# або
source venv/bin/activate   # Linux / macOS
```

### - встановити залежності
```bash
pip install -r requirements.txt
```

### - запустити Flask-сервер
```bash
python app.py
```

Сервер буде доступний за адресою:

```
http://127.0.0.1:5000
```

---
## 2. Запуск через Docker

### - побудувати Docker-образ
```bash
docker build -t homework13 .
```

### - запустити контейнер
```bash
docker run -d -p 8000:8000 --name flask_api homework13
```

API буде доступний на:

```
http://127.0.0.1:8000/students
```

---

## 3. Доступні маршрути API

| Method | Route | Description |
|--------|--------|-------------|
| **POST** | `/students` | Додати нового студента |
| **GET** | `/students?id=<id>` | Отримати студента за ID |
| **GET** | `/students?last_name=<name>` | Отримати студента(ів) за прізвищем |
| **GET** | `/students` | Отримати всіх студентів |
| **PATCH** | `/students` | Оновити лише вік |
| **PUT** | `/students` | Оновити ім’я, прізвище та вік |
| **DELETE** | `/students` | Видалити студента за ID |

---

## 4. Приклади запитів (cURL)

### - отримати всіх студентів
```bash
curl -X GET http://127.0.0.1:5000/students
```

### - створити студента
```bash
curl -X POST http://127.0.0.1:5000/students      -H "Content-Type: application/json"      -d '{"first_name": "Alex", "last_name": "DevOps", "age": "39"}'
```

### - отримати студента за ID
```bash
curl -X GET "http://127.0.0.1:5000/students?id=1"
```

### - отримати за прізвищем
```bash
curl -X GET "http://127.0.0.1:5000/students?last_name=DevOps"
```

### - оновити вік (PATCH)
```bash
curl -X PATCH http://127.0.0.1:5000/students      -H "Content-Type: application/json"      -d '{"id": "1", "age": "25"}'
```

### - оновити всі поля (PUT)
```bash
curl -X PUT http://127.0.0.1:5000/students      -H "Content-Type: application/json"      -d '{"id": "2", "first_name": "Ehor", "last_name": "Kornilov", "age": "29"}'
```

### - видалити (DELETE)
```bash
curl -X DELETE http://127.0.0.1:5000/students      -H "Content-Type: application/json"      -d '{"id": "1"}'
```

---

## 5. Автоматичне тестування

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

## 6. Структура проєкту

```
📁 homework13
 ┣ 📜 app.py              # Flask REST API
 ┣ 📜 test_requests.py    # Автотести
 ┣ 📜 results.txt         # Результат тестів
 ┣ 📜 requirements.txt    # Flask + gunicorn
 ┣ 📜 students.csv        # CSV база студентів
 ┣ 📜 Dockerfile          # Dockerfile для Homework 13
 ┣ 📜 .dockerignore       # Ігнор файлів
 ┗ 📜 README.md           # Документація (цей файл)
```

---

## Dockerfile

```dockerfile
FROM python:3.10-slim
WORKDIR /app
COPY . .
RUN pip install --no-cache-dir -r requirements.txt
EXPOSE 8000
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "app:app"]
```

---

## requirements.txt

```
Flask
gunicorn
```

---
