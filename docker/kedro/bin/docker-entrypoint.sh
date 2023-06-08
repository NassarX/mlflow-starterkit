#!/bin/bash

# Install the Python packages from requirements.txt
export PATH="${APP_HOME}/.local/bin:$PATH"

# Check if the directory exists
if [[ ! -d "${APP_HOME}/${OUTPUT_DIR}/${REPO_NAME}" ]]; then

  # Define the path to the prompts.yml file
  PROMPTS_FILE="/tmp/prompts.yml"

  # Create OUTPUT_DIR if it doesn't exist
  mkdir -p "${OUTPUT_DIR}"

  # Create the prompts.yml file
  cat <<EOF >"$PROMPTS_FILE"
project_name: ${PROJECT_NAME}
output_dir: ./${OUTPUT_DIR}
repo_name: ${REPO_NAME}
python_package: ${PYTHON_PACKAGE}
EOF

  # Create a new Kedro project
  kedro new --config "$PROMPTS_FILE" --starter=pandas-iris

fi

# Change directory to the Kedro project directory
# shellcheck disable=SC2164
cd "${APP_HOME}/${OUTPUT_DIR}/${REPO_NAME}"
pip install -r "src/requirements.txt" >/dev/null 2>&1

# Initialize the MLflow tracking server
kedro mlflow init

# Run the command
exec "$@"
