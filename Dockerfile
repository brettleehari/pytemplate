FROM python:3.9

ARG ENVIRONMENT=development

WORKDIR /app

# Install poetry
RUN pip install poetry

# Copy only requirements to cache them in docker layer
COPY pyproject.toml poetry.lock* /app/

# Project initialization:
RUN poetry config virtualenvs.create false \
    && poetry install --no-interaction --no-ansi

# Copy project
COPY . .

# Set environment-specific settings
RUN if [ "$ENVIRONMENT" = "development" ]; then \
        poetry install --dev; \
    elif [ "$ENVIRONMENT" = "staging" ]; then \
        poetry install; \
    elif [ "$ENVIRONMENT" = "production" ]; then \
        poetry install --no-dev; \
    fi

CMD ["poetry", "run", "uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]