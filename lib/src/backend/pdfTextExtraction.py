from PyPDF2 import PdfReader
from flask import Flask, request, jsonify

app = Flask(__name__)

def extract_text_from_pdf(file_path):
    reader = PdfReader(file_path)
    text = ""
    for page in reader.pages:
        text += page.extract_text()
    return text

@app.route('/extract_text', methods=['POST'])
def extract_text():
    if 'file' not in request.files:
        return jsonify({'error': 'No file part'})
    
    file = request.files['file']
    if file.filename == '':
        return jsonify({'error': 'No selected file'})
    
    if file:
        text = extract_text_from_pdf(file)
        return jsonify({'text': text})

if __name__ == '__main__':
    app.run(debug=True)