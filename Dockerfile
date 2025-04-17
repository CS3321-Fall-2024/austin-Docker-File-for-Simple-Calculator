FROM python:3.11-alpine

ENV POETRY_VERSION=1.8.2

RUN apk add --no-cache curl

RUN curl -sSL https://install.python-poetry.org | python3 - --version $POETRY_VERSION

ENV PATH="/root/.local/bin:$PATH"

WORKDIR /app

COPY pyproject.toml poetry.lock* /app/

RUN poetry install --no-root --no-interaction --no-ansi

COPY . /app

RUN poetry install --no-interaction --no-ansi

RUN poetry run pytest

CMD ["poetry", "run", "python", "src/calculator/calculator.py"]
