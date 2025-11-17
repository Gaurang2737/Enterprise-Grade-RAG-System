# Dockerfile (dev-friendly, minimal)

FROM python:3.11-slim

WORKDIR /app

# Copy only dependency files first (for caching)
COPY pyproject.toml poetry.lock /app/

# Install Poetry and project dependencies (without installing our app)
RUN pip install --no-cache-dir poetry && \
    poetry config virtualenvs.create false && \
    poetry install --no-root

# Copy whole project AFTER dependencies
COPY . /app

EXPOSE 8000

CMD ["uvicorn", "src.api.main:app", "--host", "0.0.0.0", "--port", "8000"]
