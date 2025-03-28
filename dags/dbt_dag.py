import os
from datetime import datetime

from cosmos import DbtDag, ProjectConfig, ProfileConfig, ExecutionConfig
from cosmos.profiles import SnowflakeUserPasswordProfileMapping

profile_config = ProfileConfig(
    profile_name="default",
    target_name="dev",
    profile_mapping=SnowflakeUserPasswordProfileMapping(
        conn_id="snowflake_conn",
        profile_args={"database": "dbt_db", "schema": "dbt_schema"},
    )
)

dbt_snowflake_dag = DbtDag(
    project_config=ProjectConfig("/usr/local/airflow/dags/dbt/my_dbt_project"),
    operator_args={"install_deps": True},
    profile_config=profile_config,
    execution_config=ExecutionConfig(
        # For Windows containerized environment, adjust path as needed
        dbt_executable_path=f"{os.environ['AIRFLOW_HOME']}/dbt_env/bin/dbt",  # Use just "dbt" if it's in PATH
    ),
    schedule_interval="@daily",
    start_date=datetime(2025, 3, 13),
    catchup=False,
    dag_id="dbt_dag",
)