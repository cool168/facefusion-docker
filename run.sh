#!/bin/bash
export GRADIO_SERVER_NAME=0.0.0.0
export PIP_BREAK_SYSTEM_PACKAGES=1
CUDA_VISIBLE_DEVICES=1 python facefusion.py run

