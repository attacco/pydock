# pydock

First, execute `./build.sh` (or `make build`). You will need `dockerx` installed (included in Docker Desktop). The Docker image should be built once.

After the Docker image has been built, edit newly created file `pydock.config` and set parameter `LOCAL_TNS_ADMIN`.
Value of this parameter should point to directory containing configuration files of Oracle InstantClient.
Example:
`LOCAL_TNS_ADMIN=/Users/me/apps/oracle/instantclient/network/admin`.

Then, switch to your project's root directory and execute `<pydock_path>/run.sh <path_to_your_python_script.py>`.
This command should be executed every time you need to run a Python script.

For your convenience you may register alias: `alias pydock='<pydock_path>/run.sh'`. 
In that case, execution command become more compact: `pydock <path_to_your_python_script.py>`.