import json
import typing
import requests
import pickle
import click

def load_pickle(file_path):
    with open(file_path, 'rb') as dv_bin:
        return pickle.load(dv_bin)

@click.command(help='Predict Churn')
@click.option('--customer_information', '-c', default='./test.json', type=click.File('r'), help='Path to json containing  Customer Information.')
@click.option('--url', '-u', default='', type=str, help='Url to Churn API')
def main(customer_information: typing.IO, url: str):

    customer_information = json.load(customer_information)

    if url == '':
        dv = load_pickle('./resources/dv.bin')
        model = load_pickle('./resources/model1.bin')
        
        customer_process = dv.transform(customer_information)    
        churn_proba = model.predict_proba(customer_process)[:, 1]
    else:
        churn_info = requests.post(url, json=customer_information).json()
        churn_proba = churn_info['proba']
    
    print("Churn" if churn_proba > 0.5 else "Not Churn")

if __name__ == '__main__':
    main()

