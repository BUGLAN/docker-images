FROM apache/airflow:2.0.1-python3.7

ARG AIRFLOW_HOME=/opt/airflow
ARG AIRFLOW_VERSION=2.0.1rc2
WORKDIR /opt/airflow
RUN airflow db init && airflow users create --username root --role Admin --email 1831353087@qq.com -f lan -l sheng -p root
EXPOSE 8080
CMD [ "airflow", "webserver" ]