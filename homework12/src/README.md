# REST API for Student Management (Flask)

This application implements CRUD operations for managing student records stored in a CSV file.  
Each student has the following fields: `id`, `first_name`, `last_name`, `age`.

---

## Installation

### 1. Create and activate a virtual environment
```bash
python -m venv venv
venv\Scripts\activate   # for Windows
```

### 2. Install dependencies
```bash
pip install -r requirements.txt
```

### 3. Run the Flask application
```bash
python app.py
```

The app will start at:
```
http://127.0.0.1:5000
```

---

## Available routes

| Method | Route | Description |
|--------|--------|-------------|
| **POST** | `/students` | Add a new student |
| **GET** | `/students?id=<id>` | Retrieve student by ID |
| **GET** | `/students?last_name=<name>` | Retrieve student(s) by last name |
| **GET** | `/students` | Retrieve all students |
| **PATCH** | `/students` | Update only the student’s age |
| **PUT** | `/students` | Update student’s first name, last name, and age |
| **DELETE** | `/students` | Delete student by ID |

---

## Testing the API with cURL

### 1. Retrieve all existing students (GET)
```bash
curl -X GET http://127.0.0.1:5000/students
```

### 2. Create a new student (POST)
```bash
curl -X POST http://127.0.0.1:5000/students \
     -H "Content-Type: application/json" \
     -d '{"first_name": "Alex", "last_name": "DevOps", "age": "39"}'
```

### 3. Retrieve a student by id (GET)
```bash
curl -X GET "http://127.0.0.1:5000/students?id=1"
```

### 4. Retrieve a student by last name (GET)
```bash
curl -X GET "http://127.0.0.1:5000/students?last_name=DevOps"
```

### 5. Update a student’s age (PATCH)
```bash
curl -X PATCH http://127.0.0.1:5000/students \
     -H "Content-Type: application/json" \
     -d '{"id": "1", "age": "25"}'
```

### 6. Update all fields of a student (PUT)
```bash
curl -X PUT http://127.0.0.1:5000/students \
     -H "Content-Type: application/json" \
     -d '{"id": "2", "first_name": "Ehor", "last_name": "Kornilov", "age": "29"}'
```

### 7. Delete a student by ID (DELETE)
```bash
curl -X DELETE http://127.0.0.1:5000/students \
     -H "Content-Type: application/json" \
     -d '{"id": "1"}'
```

---

## Automated Testing

To automatically test all endpoints, use the provided script:

```bash
python test_requests.py
```

All responses will be printed in the console and saved to:
```
results.txt
```

---

## Example of results.txt
```
1. Retrieve all existing students (GET)
[]

2. Create three students (POST)
{"first_name": "Alex", "last_name": "DevOps", "age": "39"}
{"first_name": "Ehor", "last_name": "Kornilov", "age": "28"}
{"first_name": "Tetyana", "last_name": "Grek", "age": "25"}

3. Retrieve information about all existing students (GET)
[{"id": "1", "first_name": "Alex", ...}]
```

---

## Project structure

```
📁 homework12
 ┣ 📜 app.py              # Flask server (API logic)
 ┣ 📜 test_requests.py    # Test script using requests
 ┣ 📜 results.txt         # Output from test_requests.py
 ┣ 📜 requirements.txt    # Dependencies (Flask, requests)
 ┣ 📜 students.csv        # Data file with students
 ┗ 📜 README.md           # Project documentation
```

