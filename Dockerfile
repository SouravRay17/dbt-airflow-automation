FROM quay.io/astronomer/astro-runtime:12.7.1


# If you're using a Python virtual environment for dbt
RUN python -m venv dbt_env && \
    . dbt_env/bin/activate && \
    pip install --no-cache-dir dbt-snowflake && \
    deactivate

# OR a simpler approach without virtual environment
# RUN pip install --no-cache-dir dbt-snowflake