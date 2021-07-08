FROM debian:bullseye

RUN apt-get update \
&& apt-get install -y git python2.7 python3 python3-pip \
&& git clone https://github.com/Baxytra/graylog2thehive /opt/graylog2thehive

WORKDIR /opt/graylog2thehive

RUN pip install -r requirements.txt

# Fix libmagic bug
RUN pip uninstall -y python-magic && pip install python-magic

ADD ./cert-graylog2thehive.pem /opt/graylog2thehive/cert.pem
ADD ./privkey-graylog2thehive.pem /opt/graylog2thehive/privkey.pem

EXPOSE 5000

VOLUME ["/var/log","/opt/graylog2thehive/conf/"]

CMD /usr/bin/python3 /opt/graylog2thehive/app.py runserver
