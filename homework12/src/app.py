from flask import Flask, request, jsonify
import csv
import os

app = Flask(__name__)

file_name = "students.csv"

if not os.path.exists(file_name):
    with open(file_name, "w", newline="") as file:
        writer = csv.writer(file)
        writer.writerow(["id", "first_name", "last_name", "age"])

def read_student():
    students = []

    with open(file_name, newline="") as file_csv:
        reader = csv.DictReader(file_csv)
        for row in reader:
            students.append(row)

    return students

def write_student(new_student):
    with open(file_name, "a", newline="") as file_csv:
        writer = csv.writer(file_csv)
        writer.writerow([
            new_student["id"],
            new_student["first_name"],
            new_student["last_name"],
            new_student["age"]
        ])

def update(all_students):
    with open(file_name, "w", newline="") as file_csv:
        fieldnames = ["id", "first_name", "last_name", "age"]
        writer = csv.DictWriter(file_csv, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(all_students)

@app.route("/students", methods=["POST"])
def add_students():
    data = request.get_json()

    keys = ("first_name", "last_name", "age")
    for key in keys:
        if key not in data:
            return jsonify("missing required fields"), 400

    students_list = read_student()
    new_student = {
        "id": len(students_list) + 1,
        "first_name": data["first_name"],
        "last_name": data["last_name"],
        "age": data["age"]
    }

    write_student(new_student)
    return jsonify(new_student), 201

@app.route("/students", methods=["GET"])
def get_student():
    students = read_student()
    id = request.args.get("id")
    last_name = request.args.get("last_name")

    if id is not None:
        for student in students:
            if student["id"] == id:
                return jsonify(student), 200
        return jsonify("id is not found"), 404

    if last_name is not None:
        search_last_name = []
        for student in students:
            if student["last_name"].lower() == last_name.lower():
                search_last_name.append(student)

        if len(search_last_name) > 0:
            return jsonify(search_last_name), 200
        else:
            return jsonify("last name is not found"), 404

    return jsonify(students), 200

@app.route("/students", methods=["PATCH"])
def update_age_student():
    data = request.get_json()

    if data is None:
        return jsonify("fields not found"), 400

    if "id" not in data:
        return jsonify("id is not found"), 400

    if "age" not in data:
        return jsonify("age is not found"), 400

    students = read_student()
    found = False

    for student in students:
        if student["id"] == str(data["id"]):
            student["age"] = data["age"]
            found = True

    if found == False:
        return jsonify("id not found"), 404

    update(students)
    return jsonify(f"age updated for id={data['id']}"), 200

@app.route("/students", methods=["PUT"])
def update_student():
    data = request.get_json()

    if data is None or "id" not in data:
        return jsonify("id not found"), 400

    keys = ("first_name", "last_name", "age")
    for key in keys:
        if key not in data:
            return jsonify("fields first_name, last_name, and age are missing"), 400

    students = read_student()
    found = False

    for student in students:
        if student["id"] == str(data["id"]):
            student["first_name"] = data["first_name"]
            student["last_name"] = data["last_name"]
            student["age"] = data["age"]
            found = True

    if found == False:
        return jsonify("id is not found"), 404

    update(students)
    return jsonify(data), 200

@app.route("/students", methods=["DELETE"])
def delete_student():
    data = request.get_json()

    if data is None or "id" not in data:
        return jsonify("id is required"), 400

    students = read_student()
    new_students = []

    for student in students:
        if student["id"] != str(data["id"]):
            new_students.append(student)

    if (len(new_students) == len(students)):
        return jsonify("id is not found"), 404

    update(new_students)
    return jsonify("student deleted"), 200

if __name__ == "__main__":
    app.run(debug=True)
