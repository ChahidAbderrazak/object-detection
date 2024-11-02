ARG PYTHON_VERSION=python:3.8
ARG OPENJDK_VERSION=openjdk:8-slim-buster
ARG APP_SERVER_PORT=8383
# python
FROM $PYTHON_VERSION AS py3
ENV PYTHONUNBUFFERED 1

# java
FROM $OPENJDK_VERSION
COPY --from=py3 / /

# copy the code files
WORKDIR /app
COPY src ./src
COPY config .
COPY requirements.txt .
COPY setup.py .
COPY README.md .

# Build the environnement
RUN pip install --upgrade pip
RUN pip install --no-cache-dir --upgrade -r requirements.txt

EXPOSE $APP_SERVER_PORT
CMD ["python", "src/main.py"]
# CMD ["uvicorn", "src.webserver:app", "--host", "0.0.0.0", "--port", "${WEBAPP_SERVER_PORT}"]