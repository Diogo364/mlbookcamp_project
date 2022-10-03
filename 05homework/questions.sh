# !/bin/bash

if [ ! -f Pipfile ]; then
    echo "Running setup"
    ./set_up.sh
fi

echo "Question 1"
echo "What's the version of pipenv you installed?"
echo "- Answer: $(pipenv --version)"

echo ""
echo "Question 2"
echo "What's the first hash for scikit-learn you get in Pipfile.lock?"
HASH=$(grep "scikit-learn" -A2 Pipfile.lock | grep -Po "sha.*")
echo "- Answer: ${HASH}"

echo ""
echo "Question 3"
echo "Score this client: {'reports': 0, 'share': 0.001694, 'expenditure': 0.12, 'owner': 'yes'}"
echo "- Answer: $(pipenv run python predict.py)"

echo ""
echo "Question 4"
echo "Now score this client using requests:"
GUNICORNPROCESS=$(lsof -i :8080 | grep gunicorn | cut -d " " -f2)
if [ ! -z "$GUNICORNPROCESS" ]; then
    echo "Gunicorn already up."
    for pid in $GUNICORNPROCESS; 
    do
        echo "Killing Gunicorn process"
        kill -9 $pid
    done
fi

pipenv run gunicorn --bind 0.0.0.0:8080 flaskapp:app > /dev/null 2>&1 &
sleep 5
echo "- Answer: $(pipenv run python predict.py --url http://0.0.0.0:8080/predict --customer_information ./test2.json)"

GUNICORNPROCESS=$(lsof -i :8080 | grep gunicorn | cut -d " " -f2)
if [ ! -z "$GUNICORNPROCESS" ]; then
    echo "Gunicorn already up."
    for pid in $GUNICORNPROCESS; 
    do
        echo "Killing Gunicorn process"
        kill -9 $pid
    done
fi

DOCKERIMAGE=svizor/zoomcamp-model
DOCKERTAG=3.9.12-slim

echo ""
echo "Question 5"
echo "Download the base image svizor/zoomcamp-model:3.9.12-slim. You can easily make it by using docker pull command."
echo "So what's the size of this base image?"
docker pull "$DOCKERIMAGE:$DOCKERTAG"
image_size=$(docker image ls | grep $DOCKERIMAGE | grep -o -P "\d*MB")
echo "- Answer: $image_size"


echo ""
echo "Question 6"
echo "Let's run your docker container!"

docker build -t credit-flask:latest .
docker run -d -p 8080:8080 --name credit-api credit-flask:latest
sleep 5
echo "- Answer: $(pipenv run python predict.py --url http://0.0.0.0:8080/predict --customer_information ./test2.json)"
docker stop credit-api && docker rm credit-api
