from flask import Flask, request, jsonify
from flask_cors import CORS
import openai
import os
from dotenv import load_dotenv

load_dotenv()

app = Flask(__name__)
CORS(app)

openai.api_key = os.getenv('OPENAI_API_KEY')

@app.route('/chat', methods=['POST'])
def chat():
    data = request.json
    user_message = data.get('message', '')

    # Translate user message to English if necessary (simulated here)
    translated_message = translate_to_english(user_message)
    
    # Get response from OpenAI
    response = openai.Completion.create(
        engine="davinci-codex",
        prompt=f"Reply to this message in Akan (Twi): {translated_message}",
        max_tokens=150
    )
    bot_message = response.choices[0].text.strip()

    return jsonify({"reply": bot_message})

def translate_to_english(message):
    # Simulate translation (replace with actual translation logic if available)
    return message

if __name__ == '__main__':
    app.run(debug=True)
