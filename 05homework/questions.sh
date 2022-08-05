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
echo "Score this customer: {'contract': 'two_year', 'tenure': 12, 'monthlycharges': 19.7}"
echo "- Answer: $(pipenv run python predict.py)"

echo ""
echo "Question 4"
echo "Now score this customer using requests:"
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

if [ ! -z "$GUNICORNPROCESS" ]; then
    echo "Gunicorn already up."
    for pid in $GUNICORNPROCESS; 
    do
        echo "Killing Gunicorn process"
        kill -9 $pid
    done
fi