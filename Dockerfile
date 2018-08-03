FROM ubuntu:trusty

RUN apt-get update
RUN apt-get dist-upgrade -y

RUN apt-get install sudo -y
RUN apt-get install python-cups python-dateutil \
    python-decorator python-docutils python-feedparser -y
RUN apt-get install python-gdata python-geoip python-gevent \
    python-imaging python-jinja2 python-ldap \
    python-libxslt1 python-lxml python-mako python-mock python-openid python-passlib \
    python-psutil python-psycopg2 python-pybabel python-pychart python-pydot python-pyparsing \
    python-pypdf python-reportlab python-requests python-simplejson python-tz python-unicodecsv \
    python-unittest2 python-vatnumber python-vobject -y
RUN apt-get install python-werkzeug python-xlwt python-yaml wkhtmltopdf \
    python-pip python-dev libevent-dev gcc libxml2-dev libxslt-dev node-less \
    geoip-database-contrib -y
RUN apt-get install git -y
RUN useradd -ms /bin/bash odoodev
RUN echo "odoodev ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
ENV ODOO_PROJECT_DICT /home/odoodev/Odoo
ENV ODOO_CORE_DICT /home/odoodev/Odoo/Odoo9
USER odoodev
RUN mkdir $ODOO_PROJECT_DICT
RUN mkdir $ODOO_CORE_DICT
RUN git clone https://github.com/odoo/odoo.git --depth 1 --branch 9.0 --single-branch $ODOO_CORE_DICT
WORKDIR /home/odoodev/Odoo
RUN sudo touch /usr/bin/odoo_run
ADD ./odoo_run /usr/bin/odoo_run
RUN sudo chmod +x /usr/bin/odoo_run
ADD entrypoint.sh /usr/local/bin/entrypoint.sh
ADD supervisord.conf /etc/supervisord.conf
RUN sudo chmod +x /usr/local/bin/entrypoint.sh
RUN sudo easy_install supervisor
RUN ls -al /usr/local/bin/entrypoint.sh
EXPOSE 22 8069
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

