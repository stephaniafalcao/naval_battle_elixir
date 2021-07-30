FROM elixir:latest

RUN apt-get update && \
    apt-get install -y inotify-tools && \
    apt-get install -y nodejs && \
    curl -L https://npmjs.org/install.sh | sh 
    #&& \
    #mix local.hex --force && \ 
    #mix archive.install hex phx_new 1.5.9 --force && \
    #mix local.rebar --force # pesquisar

ENV APP_HOME /app

RUN mkdir $APP_HOME

RUN groupadd --gid 1196425729 stephania

RUN useradd -l --uid 1196446367 --gid 1196425729 stephania

RUN mkdir /home/stephania 

RUN chown stephania:stephania /home/stephania

USER stephania

WORKDIR $APP_HOME

ENTRYPOINT [ "./entrypoint.sh" ]