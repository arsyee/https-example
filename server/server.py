from flask import Flask

app = Flask(__name__)

@app.route("/")
def hello_world():
    return "Hello, World!\n"

if __name__ == '__main__':
    cert_file = 'cert.crt'
    key_file = 'cert.key'

    app.run(
        host='localhost',
        port=8080,
        debug=True,
        ssl_context=(cert_file, key_file)
    )
