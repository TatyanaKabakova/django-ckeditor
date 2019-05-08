FROM python:3.4
# all code from repo will be added to container's folder "ckeditor"
ADD . /ckeditor
ENV DJANGO_SETTINGS_MODULE ckeditor_demo.settings
RUN pip install -r /ckeditor/ckeditor_demo_requirements.txt
RUN pip install /ckeditor
RUN python /ckeditor/manage.py collectstatic --noinput
#RUN python /ckeditor/manage.py migrate --noinput
# 0.0.0.0 is for making the server available outside the container
CMD python /ckeditor/manage.py runserver 0.0.0.0:8080


# Build an image from a Dockerfile with giving it a tag
# docker build --tag=django-ckeditor .

# -it runs the container interactively and binds it to the console for interaction
# --rm will remove the current container after exiting

# --publish option allows you to map public IP/Port addresses from a running local container to a local Port
# https://www.proxydocker.com/ru/routerpassword/192.168.0.110

# docker run -it --rm --publish=192.168.0.110:8080:8080 django-ckeditor
# In this example, 192.168.0.110 is the port of the host. The public port can be accessed through 8080 from my localhost
# Without the publish option, the server will be accessible only from the running IP address of the container.

# docker run -it --rm --network=host django-ckeditor
# If you use --network=host, the process(es) in your container open port directly on host network
# (by giving full access to local system services) so you cannot change the port number, it uses the one in the code.
# -p is used to open/map a port in the host network from the container (it's like a proxy)
# so you don't need --network=host.


# docker run -it --rm --publish=127.0.0.1:8080:8080 django-ckeditor

# docker run -p 127.0.0.1:5433:5432 -d postgres:9.4
# createdb -h localhost test_db -p 5433 -U postgres

# docker run -it --rm --link=stoic_curran:db -e DATABASE=postgres://postgres@db/test_db --publish=127.0.0.1:8080:8080 django-ckeditor python /ckeditor/manage.py migrate
# docker run -it --rm --link=stoic_curran:db -e DATABASE=postgres://postgres@db/test_db --publish=127.0.0.1:8080:8080 django-ckeditor