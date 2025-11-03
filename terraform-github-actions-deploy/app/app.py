from flask import Flask
app = Flask(__name__)

@app.route('/')
def home():
    return "Hello from Terraform + GitHub Actions + EC2! - Version 2.0"

@app.route('/health')
def health():
    return {"status": "healthy"}, 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
