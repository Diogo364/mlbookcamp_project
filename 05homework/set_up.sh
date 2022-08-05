# !/bin/bash

echo "Installing pipenv"
pip install pipenv

wait

echo "Using pipenv to install python libs"
pipenv install --python 3.8 
pipenv install numpy scikit-learn==1.0 flask gunicorn click requests

if [ ! -d ./resources ]; then
    echo "Creating ./resources directory"
    mkdir ./resources
fi

echo "Downloading resources if needed"
REPO=https://raw.githubusercontent.com/alexeygrigorev/mlbookcamp-code/master/course-zoomcamp/05-deployment/homework

if [ ! -f ./resources/dv.bin ]; then
    echo "Downloading DictVectorizer"
    wget $REPO/dv.bin -P ./resources
fi

if [ ! -f ./resources/model1.bin ]; then
    echo "Downloading LogisticRegression model"
    wget $REPO/model1.bin -P ./resources
fi