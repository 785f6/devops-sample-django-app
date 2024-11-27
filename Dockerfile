FROM python:3.8

WORKDIR /app

COPY requirements.txt /app/

RUN pip install --no-cache-dir -r requirements.txt \
    && pip install --no-cache-dir uwsgi

COPY . /app/

ENV DJANGO_DB_HOST=db \
    DJANGO_DB_NAME=app \
    DJANGO_DB_USER=worker \
    DJANGO_DB_PASS=worker \
    DJANGO_DB_PORT=5432 \
    DJANGO_DEBUG=False

CMD ["uwsgi", "--http", "0.0.0.0:8000", "--module", "parrotsite.wsgi:application", "--uid", "1000", "--gid", "1000"]