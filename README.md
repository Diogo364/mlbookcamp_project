# ML Bookcamp Project

## Table of Contents
- [ML Bookcamp Project](#ml-bookcamp-project)
  - [Table of Contents](#table-of-contents)
  - [About](#about)
  - [Repo Structure](#repo-structure)
    - [Environment](#environment)
    - [Conda](#conda)
    - [Docker](#docker)
  - [References](#references)


## About
This repo contains all the code and projects developed by following the MLBookCamp-code Course offered by [DataTalks.Club](https://datatalks.club/) and [Alexey Grigorev](https://github.com/alexeygrigorev).

## Repo Structure
All homework questions are solved in Jupyter Notebook format at the root of the repository. Further custom code might be found inside a few packages, such as `model`.

### Environment
Choose one of the following environment instructions below to build all dependencies to the project.

### Conda
All requiments needed to run the project might be found within the `docker/resources/conda.yml` file, which might be used to build a conda environment easily through the command:
```
conda env create -f docker/resources/conda.yml
```
> **Obs:** Conda or Miniconda are required for this setup.

### Docker
It is also possible to run the project through a local Jupyter Notebook by using a Docker Container in a few steps. 

1. Access the `.env` file to customise the environment variables.
    > Note: Map the `USER_UID` variable to your User ID.

2. Build the Docker Image by running the command:
    ```
    docker-compose build
    ```

3. Run the Docker container in detached mode by running:
    ``` 
    docker-compose up -d
    ```
4. Verify if your container is running through the command below:
    ```
    docker ps
    ```
    > Note: You should see an output like this:
    ```
    CONTAINER ID   IMAGE                     COMMAND                  CREATED         STATUS         PORTS                                       NAMES
    03ca4cdb7893   miniconda-docker:latest   "jupyter notebook --…"   3 minutes ago   Up 3 minutes   0.0.0.0:8000->8000/tcp, :::8000->8000/tcp   mlbookcamp_project_myenv_1
    ```

After this last step you should be able to access a local instance of Jupyter Notebook in the following link: http://localhost:8000/
> **Important:** The default authentication token is `DOCKERNOTEBOOK`, but it can be changed in the `.env` file.

> **Obs:** Docker and Docker-Compose are required to this setup.

## References
- mlbookcamp-code: https://github.com/alexeygrigorev/mlbookcamp-code/