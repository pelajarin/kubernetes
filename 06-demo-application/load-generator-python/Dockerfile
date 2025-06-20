FROM python:3.12-slim AS generate-requirements
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*
RUN pip install poetry==1.8.5
COPY pyproject.toml poetry.lock ./
RUN poetry export --output requirements.txt

###

FROM python:3.12-slim AS production
COPY --from=generate-requirements /requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . . 
CMD ["python", "main.py"]
