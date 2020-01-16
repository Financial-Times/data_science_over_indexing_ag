FROM rocker/r-ver:3.6.1

ADD packrat /usr/local/job/packrat
ADD ag_over_indexing /usr/local/job/ag_over_indexing

# Only for development adding config.json path as environment variable
# ENV EXECUTION_ENVIRONMENT_CONFIG_PATH /usr/local/airflow/execution_environment/config/config.json
# ADD config.json ${EXECUTION_ENVIRONMENT_CONFIG_PATH}

WORKDIR "/usr/local/job"

RUN R -e 'install.packages("packrat", repos="http://cran.us.r-project.org");'
RUN R -e 'packrat::restore()'
RUN R -e 'packrat::init()'

CMD Rscript /usr/local/job/ag_over_indexing/app.r "${EXECUTION_ENVIRONMENT_CONFIG_PATH}"
