FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1 ENV PYTHONUNBUFFERED=1 ENV PIPNOCACHE_DIR=1

WORKDIR /app

RUN addgroup --system django
&& adduser --system --ingroup django django

COPY requirements.txt /app/requirements.txt

RUN pip install --upgrade pip
&& pip install -r requirements.txt

COPY . /app

RUN python manage.py collectstatic --noinput
&& chown -R django:django /app

USER django

EXPOSE 8000

CMD ["gunicorn", "--bind", "0.0.0.0:8000", "--workers", "2", "--access-logfile", "-", "--error-logfile", "-", "weather_project.wsgi:application"]