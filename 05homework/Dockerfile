FROM svizor/zoomcamp-model:3.9.12-slim

COPY ./set_up.sh ./
COPY ./flaskapp.py ./

RUN apt-get update -y
RUN apt-get install -y wget

RUN ./set_up.sh

CMD [ "pipenv", "run", "gunicorn", "--bind", "0.0.0.0:8080", "flaskapp:app" ]