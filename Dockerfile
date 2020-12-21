FROM python:3.7-slim
MAINTAINER Open Risk <www.openriskmanagement.com>
LABEL maintainer="info@openrisk.eu"
EXPOSE 8080
ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1
ENV DJANGO_SETTINGS_MODULE openNPL.settings
ENV DJANGO_ALLOWED_HOSTS localhost 127.0.0.1 [::1]
RUN mkdir /opennpl
WORKDIR /opennpl
COPY requirements.txt /opennpl/
RUN pip install -r requirements.txt
COPY . /opennpl/
RUN rm /opennpl/db.sqlite3
RUN python /opennpl/manage.py makemigrations
RUN python /opennpl/manage.py migrate
RUN python /opennpl/createadmin.py
RUN python /opennpl/manage.py collectstatic --no-input
RUN python /opennpl/manage.py loaddata --format=json npl_portfolio  /opennpl/npl_portfolio/fixtures/npl_portfolio.json
CMD [ "python", "./manage.py", "runserver", "0.0.0.0:8080"]