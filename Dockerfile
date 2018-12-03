FROM python:2.7.15


LABEL maintainer="Christoph Schreyer <christoph.schreyer@stud.uni-regensburg.de>"


RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get -y install \
 cron \
 postfix

COPY praktomat_grading.py /usr/local/bin/praktomat_grading.py
RUN sed -i "s/DB_HOST/${HOST}/g" /usr/local/bin/praktomat_grading.py \
&& sed -i "s/DB_PORT/${PORT}/g" /usr/local/bin/praktomat_grading.py \
&& sed -i "s/DB_NAME/${NAME}/g" /usr/local/bin/praktomat_grading.py \
&& sed -i "s/DB_USER/${USER}/g" /usr/local/bin/praktomat_grading.py \
&& sed -i "s/DB_PASS/${PASS}/g" /usr/local/bin/praktomat_grading.py
RUN echo "0 2 * * 2 root python /usr/local/bin/praktomat_grading.py" >> /etc/crontab

