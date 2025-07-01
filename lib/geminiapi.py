import google.generativeai as genai
from flask import Flask, jsonify, request

genai.configure(api_key="AIzaSyAQjhFCtyQcx9qJMCNMHyZatrHXnKPIfXk")
model = genai.GenerativeModel("gemini-1.5-flash")
response = model.generate_content("Explain how AI works")
print(response.text)

app = Flask(__name__)

class MyPythonClass:
    API_KEY = "AIzaSyAQjhFCtyQcx9qJMCNMHyZatrHXnKPIfXk"
    genai.configure(api_key="AIzaSyAQjhFCtyQcx9qJMCNMHyZatrHXnKPIfXk")
    model = genai.GenerativeModel("gemini-1.5-flash")

    def __init__(self):
        genai.configure(api_key=self.API_KEY)
    def my_function(self, param):
        return model.generate_content(param).text

# Instantiate the Python class
my_python_class = MyPythonClass()

@app.route('/call_function', methods=['POST'])
def call_function():
    data = request.get_json()  # Get JSON data from the POST request
    param = data.get('param')
    result = my_python_class.my_function(param)  # Call the Python function
    return jsonify({"result": result})  # Return the result as JSON

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)

