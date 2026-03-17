import os
from flask import Flask, request, jsonify
import requests

app = Flask(__name__)

BOT_TOKEN = os.environ.get('TELEGRAM_BOT_TOKEN')
CHAT_ID = os.environ.get('TELEGRAM_CHAT_ID')

@app.route('/send', methods=['POST'])
def send():
    data = request.json or {}
    title = data.get('title') or 'Заявка с сайта'
    body = data.get('body') or ''
    message = f"{title}\n\n{body}"

    if not BOT_TOKEN or not CHAT_ID:
        return jsonify({'ok': False, 'error': 'TELEGRAM_BOT_TOKEN or TELEGRAM_CHAT_ID not configured'}), 500

    tg_url = f'https://api.telegram.org/bot{BOT_TOKEN}/sendMessage'
    resp = requests.post(tg_url, json={'chat_id': CHAT_ID, 'text': message})
    if resp.status_code != 200:
        return jsonify({'ok': False, 'error': resp.text}), 502
    return jsonify({'ok': True})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=int(os.environ.get('PORT', 5000)))
