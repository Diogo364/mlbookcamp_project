import pickle
from flask import Flask, jsonify, request

app = Flask('Churn API')

def load_pickle(file_path):
    with open(file_path, 'rb') as dv_bin:
        return pickle.load(dv_bin)

@app.route('/predict', methods=['POST'])
def predict():    
    
    customer_information = request.get_json()

    dv = load_pickle('./resources/dv.bin')
    model = load_pickle('./resources/model1.bin')
    
    customer_process = dv.transform(customer_information)    
    churn_proba = model.predict_proba(customer_process)[:, 1]
    
    return jsonify(
        {
            'proba': float(churn_proba),
            'churn': bool(churn_proba >= 0.5)
        }
    )
if __name__ == '__main__':
    app.run('0.0.0.0', port=8080, debug=True)