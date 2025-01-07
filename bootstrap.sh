#!/usr/bin/env bash

curl -LsSf https://astral.sh/uv/install.sh | sh

uv venv
source .venv/bin/activate
uv pip install -r requirements.txt
