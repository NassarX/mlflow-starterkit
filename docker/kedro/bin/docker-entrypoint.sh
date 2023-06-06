#!/bin/bash

# Define the path to the prompts.yml file
PROMPTS_FILE="/tmp/prompts.yml"

# Create OUTPUT_DIR if it doesn't exist
mkdir -p "${OUTPUT_DIR}"

# Create the prompts.yml file
cat << EOF > "$PROMPTS_FILE"
project_name: ${PROJECT_NAME}
output_dir: ${OUTPUT_DIR}
repo_name: ${REPO_NAME}
python_package: ${PYTHON_PACKAGE}
EOF

# Check if the directory exists
if [[ ! -d "${OUTPUT_DIR}/${REPO_NAME}" ]]; then
  # Create a new Kedro project
  kedro new --config "$PROMPTS_FILE" --starter=pandas-iris --verbose
fi

# Change directory to the Kedro project directory
# shellcheck disable=SC2164
cd "${OUTPUT_DIR}/${REPO_NAME}"

# Install the Python packages from requirements.txt
pip install -r "src/requirements.txt"

export PATH="${APP_HOME}/.local/bin:$PATH"

# Run Kedro command: run
yes | kedro run &

# Run the command
exec "$@"