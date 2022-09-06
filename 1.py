from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello():
    return 'Hello World!'


app.run(host='127.0.0.1', debug=True, port=5000)
