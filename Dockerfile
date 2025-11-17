# Dockerfile (dev-friendly, minimal)

FROM python:3.11-slim

WORKDIR /app

# Copy only dependency files first (for caching)
COPY pyproject.toml poetry.lock /app/

# Install Poetry inside container and project dependencies
RUN pip install --no-cache-dir poetry && \
    poetry config virtualenvs.create false && \
    poetry install

# Copy entire project
COPY . /app

# Expose the API port
EXPOSE 8000

# Run FastAPI app
CMD ["uvicorn", "src.api.main:app", "--host", "0.0.0.0", "--port", "8000"]
