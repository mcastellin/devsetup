import os
import boto3
import botocore
import click
from pathlib import Path

home_dir = Path.home()
RC_PARAMS_FILE = f"{home_dir}/.zshrc.d/user_env.sh"
AWS_REGION = os.getenv("AWS_REGION", default="eu-west-1")
AWS_PROFILE = os.getenv("AWS_PROFILE", default="pat-parameters")
AWS_ENDPOINT = os.getenv("AWS_ENDPOINT")
PARAM_KEY_PREFIX = os.getenv("PARAM_KEY_PREFIX", default="/pat/parameters/")


# TODO this client should assume the param manager role
# or account used for credentials should have the policy assigned directly
boto3.setup_default_session(profile_name=AWS_PROFILE)
client = boto3.client(
    "ssm",
    endpoint_url=AWS_ENDPOINT,
    region_name=AWS_REGION,
)


def read_new_parameter_from_user():
    name = input("Enter the name of the variable: ")
    value = input("Enter the parameter value: ")
    return name, value


def get_parameter_key(name: str) -> str:
    if not name or len(name) == 0:
        raise ValueError("Parameter name is invalid.")

    key_name = name.lower().replace("_", "/")
    return f"{PARAM_KEY_PREFIX}{key_name}"


def read_parameters():
    results = client.get_parameters_by_path(
        Path=PARAM_KEY_PREFIX, Recursive=True
    )
    parameters = []
    for param in results["Parameters"]:
        response = client.list_tags_for_resource(
            ResourceType="Parameter", ResourceId=param["Name"]
        )
        tags = response["TagList"]
        original_name = None
        for t in tags:
            if t["Key"] == "OriginalName":
                original_name = t["Value"]
                break
        parameters.append(
            {
                "Key": param["Name"],
                "Name": original_name,
                "Value": param["Value"],
            }
        )
    return parameters


def put_parameter(name, value):
    key = get_parameter_key(name)
    options = {}
    try:
        client.get_parameter(Name=key)
        options["Overwrite"] = True
    except client.exceptions.ParameterNotFound:
        options["Tags"] = [{"Key": "OriginalName", "Value": name}]

    try:
        return client.put_parameter(
            Name=key, Value=value, Type="String", **options
        )
    except botocore.exceptions.ClientError as e:
        print("Unable to store prameter in SSM. Client Error")
        raise e


@click.group(invoke_without_command=False)
@click.pass_context
def cli(ctx):
    pass


@cli.command(name="put")
def put():
    name, value = read_new_parameter_from_user()
    response = put_parameter(name, value)
    status_code = response["ResponseMetadata"]["HTTPStatusCode"]
    if status_code == 200:
        print(f"New value for {name} parameter stored correctly.")
    else:
        raise ValueError(
            f"Error while storing the SSM parameter: {status_code}"
        )


@cli.command(name="ls")
def ls():
    params = read_parameters()
    for p in params:
        print(f"{p['Name']}: {p['Key']}")


@cli.command(name="sync")
def sync():
    params = read_parameters()
    with open(RC_PARAMS_FILE, "w") as rcfile:
        for p in params:
            name = p["Name"]
            value = p["Value"]
            rcfile.write(f'export {name}="{value}"\n')


if __name__ == "__main__":
    cli()
