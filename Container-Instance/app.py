from flask import Flask

app = Flask(__name__)

@app.route('/')
def welcome():
    return '''
    <html>
        <head><title>Welcome</title></head>
        <body style="text-align:center; font-family:sans-serif; margin-top:100px;">
            <h1>Hello from Azure Container Instance!</h1>
            <p>This Python app is running inside a Docker container on ACI.</p>
        </body>
    </html>
    '''

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
