from typing import List
from dagster import (
    asset, 
    AssetExecutionContext, 
    AssetIn, 
    Definitions,
    define_asset_job,
    AssetSelection,
    ScheduleDefinition,
)

@asset(name="FirstAsset",group_name="LetsGetStarted")
def my_first_asset(context: AssetExecutionContext):
    """
    This is our first asset for testing purposes
    """
    print("This is a print message!")
    context.log.info("this is a log message.")
    return [1,2,3]

@asset(name="SecondAsset",group_name="LetsGetStarted",
       ins={"first_upstream": AssetIn("FirstAsset")})
def my_second_asset(context: AssetExecutionContext, first_upstream: List):
    """
    This is our second asset for testing purposes
    """
    data = first_upstream + [4,5,6]
    context.log.info(f"Output data is {data}")
    return data

@asset(name="ThirdAsset",group_name="LetsGetStarted",
       ins={
        "first_upstream": AssetIn("FirstAsset"),
        "second_upstream": AssetIn("SecondAsset")
    })
def my_third_asset(
    context: AssetExecutionContext, 
    first_upstream: list, 
    second_upstream: list):
    """
    This is our third asset for testing purposes
    """
    data = {"first_asset": first_upstream,
            "second_asset": second_upstream,
            "third_asset": second_upstream + [7,8,9]
    }
    context.log.info(f"Output data is {data} & run id {context.run_id} ")
    return data

defs = Definitions(
    assets=[my_first_asset,my_second_asset,my_third_asset],
    jobs=[
        define_asset_job(
            name="hello_dagster_job",
            #selection=[my_first_asset,my_second_asset,my_third_asset]
            selection=AssetSelection.groups("LetsGetStarted")
        )
    ],
    schedules=[
        ScheduleDefinition(
            name="hello_dagster_schedule",
            job_name="hello_dagster_job",
            cron_schedule="*/2 * * * *"
        )
        
    ]
)