# backend
[![Deploy to Azure](https://github.com/WildHorseANI/backend/actions/workflows/main_anibackendtest.yml/badge.svg)](https://github.com/WildHorseANI/backend/actions/workflows/main_anibackendtest.yml)

Backend for AWHC's app. The backend is hosted on [Azure](https://anibackendtest.azurewebsites.net/).


## Development

### Running the server 
#### Using `docker compose`
Using a python venv is reccomended. Create one with `python -m vemv .venv` and then `source .venv/bin/activate`. 
1. Install dependences with `pip install -r requirements.txt`
2. Install OpenCV dependencies, if needed
3. Run the app with `docker compose up --build`

#### Using `docker`
1. Build the container with `docker build -t <tag-name>`
2. Run the container with `docker run -p <port>:80 <tag-name>`

### Deployment
There is a CI in place to build & deploy whenever the `main` branch is pushed.
