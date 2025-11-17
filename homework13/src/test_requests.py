import requests
import json

url = "http://127.0.0.1:5000/students"

results = []

response = requests.get(url)
result_text = "1. Retrieve all existing students (GET)\n" + response.text + "\n"
results.append(result_text)

student_1 = {"first_name": "Alex", "last_name": "DevOps", "age": "39"}
student_2 = {"first_name": "Ehor", "last_name": "Kornilov", "age": "28"}
student_3 = {"first_name": "Tetyana", "last_name": "Grek", "age": "25"}

students_to_add = []
students_to_add.append(student_1)
students_to_add.append(student_2)
students_to_add.append(student_3)

for student in students_to_add:
    response = requests.post(url, json=student)
    result_text = "2. Create three students (POST)\n" + response.text + "\n"
    results.append(result_text)

response = requests.get(url)
result_text = "3. Retrieve information about all existing students (GET)\n" + response.text + "\n"
results.append(result_text)

update_data_patch = {"id": "2", "age": "29"}
response = requests.patch(url, json=update_data_patch)
result_text = "4. Update the age of the second student (PATCH)\n" + response.text + "\n"
results.append(result_text)

response = requests.get(url + "?id=2")
result_text = "5. Retrieve information about the second student (GET)\n" + response.text + "\n"
results.append(result_text)

update_data_put = {
    "id": "3",
    "first_name": "Tetyana",
    "last_name": "Grek",
    "age": "26"
}
response = requests.put(url, json=update_data_put)
result_text = "6. Update the first name, last name and the age of the third student (PUT)\n" + response.text + "\n"
results.append(result_text)

response = requests.get(url + "?id=3")
result_text = "7. Retrieve information about the third student (GET)\n" + response.text + "\n"
results.append(result_text)

response = requests.get(url)
result_text = "8. Retrieve all existing students (GET)\n" + response.text + "\n"
results.append(result_text)

delete_data = {"id": "1"}
response = requests.delete(url, json=delete_data)
result_text = "9. Delete the first user (DELETE)\n" + response.text + "\n"
results.append(result_text)

response = requests.get(url)
result_text = "10. Retrieve all existing students (GET)\n" + response.text + "\n"
results.append(result_text)

with open("results.txt", "w", encoding="utf-8") as file:
    for result in results:
        file.write(result)
        file.write("\n")

print("results saved in results.txt")
