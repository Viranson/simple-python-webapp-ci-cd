FROM python:2.7


# Run the image as a non-root user
RUN groupadd -g 999 python && \
    useradd -r -u 999 -g python python

# Creating Application Source Code Directory
RUN mkdir -p /usr/src/app && chown python:python /usr/src/app

# Setting Home Directory for containers
WORKDIR /usr/src/app

# Installing python dependencies
COPY requirements.txt /usr/src/app/
RUN pip install --no-cache-dir -r requirements.txt

# Copying src code to Container
COPY --chown=python:python . /usr/src/app

# Application Environment variables
#ENV APP_ENV development
#ENV PORT 8080

# Exposing Ports
# EXPOSE $PORT

# Setting Persistent data
VOLUME ["/app-data"]

USER 999

# Running Python Application
CMD gunicorn --bind 0.0.0.0:$PORT -c gunicorn.conf.py main:app
