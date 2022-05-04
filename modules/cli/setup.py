from setuptools import setup

setup(
    name="devsetup-cli",
    version="0.1.0",
    py_modules=["devsetup_cli"],
    install_requires=[
        "Click",
        "boto3",
    ],
    entry_points={
        "console_scripts": [
            "devsetup-params = devsetup_params:cli",
        ],
    },
)
