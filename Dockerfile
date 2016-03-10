FROM nodesource/trusty:4.2.3 
RUN useradd -m dev
ADD https://github.com/eugef/github-leaderboard/archive/master.tar.gz /tmp/
RUN mkdir -p /home/dev/gl && tar --strip-components=1 -xzf /tmp/master.tar.gz -C /home/dev/gl
COPY run.sh /home/dev/gl
RUN chown -R dev:dev /home/dev
WORKDIR /home/dev/gl
RUN ls -la
RUN su -c "npm install" dev
EXPOSE 8888
