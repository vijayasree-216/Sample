FROM ubuntu
RUN echo Hello World
RUN apt-get update -y
RUN apt-get install git -y
CMD ["Hello"]