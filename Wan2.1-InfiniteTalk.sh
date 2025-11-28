#!/bin/bash

# This file will be sourced in init.sh

# https://raw.githubusercontent.com/ai-dock/comfyui/main/config/provisioning/default.sh

# Packages are installed after nodes so we can fix them...

# on RTX 5090: force update ComfyUI.

# pip uninstall -y torch torchvision torchaudio
# pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu128
# pip install -U --pre triton
#maybe# pip install -U xformers

DEFAULT_WORKFLOW="https://raw.githubusercontent.com/kijai/ComfyUI-WanVideoWrapper/refs/heads/main/example_workflows/wanvideo_I2V_InfiniteTalk_example_03.json"

APT_PACKAGES=(
    "aria2" # for downloading models
)

PIP_PACKAGES=(
    "sageattention"
    "xformers"
)

COMFYUI_NODES=(
    # Common ComfyUI Nodes
    "https://github.com/crystian/ComfyUI-Crystools"
    "https://github.com/ltdrdata/ComfyUI-Impact-Pack"
    "https://github.com/ltdrdata/ComfyUI-Inspire-Pack"
    "https://github.com/WASasquatch/was-node-suite-comfyui"
    "https://github.com/rgthree/rgthree-comfy"
    "https://github.com/cubiq/ComfyUI_essentials"
    "https://github.com/chrisgoringe/cg-use-everywhere"
    "https://github.com/pythongosssss/ComfyUI-Custom-Scripts"
    "https://github.com/kijai/ComfyUI-KJNodes"
    "https://github.com/adieyal/comfyui-dynamicprompts"

    # TTS-Audio-Suite Nodes
    "https://github.com/diodiogod/TTS-Audio-Suite"

    # Wan2.1 & InfiniteTalk Nodes
    "https://github.com/kijai/ComfyUI-WanVideoWrapper"
    "https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite"
    "https://github.com/kijai/ComfyUI-MelBandRoFormer"
)

CKPT_MODELS=(
    # "model url to be downloaded to ${WORKSPACE}/ComfyUI/models/ckpt"
)

DIFFUSION_MODELS=(
    # "model url to be downloaded to ${WORKSPACE}/ComfyUI/models/diffusion_models"
    "https://huggingface.co/city96/Wan2.1-I2V-14B-480P-gguf/resolve/main/wan2.1-i2v-14b-480p-Q4_0.gguf?download=true"
    "https://huggingface.co/Kijai/WanVideo_comfy_GGUF/resolve/main/InfiniteTalk/Wan2_1-InfiniteTalk_Single_Q8.gguf?download=true"
    "https://huggingface.co/Kijai/MelBandRoFormer_comfy/resolve/main/MelBandRoformer_fp16.safetensors?download=true"
)

UNET_MODELS=(
    # "model url to be downloaded to ${WORKSPACE}/ComfyUI/models/unet"
)

LORA_MODELS=(
    # "model url to be downloaded to ${WORKSPACE}/ComfyUI/models/loras"
    "https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/Lightx2v/lightx2v_I2V_14B_480p_cfg_step_distill_rank16_bf16.safetensors?download=true"
)

VAE_MODELS=(
    # "model url to be downloaded to ${WORKSPACE}/ComfyUI/models/vae"
    "https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/vae/wan_2.1_vae.safetensors?download=true"
)

TEXT_ENCODERS=(
    # "model url to be downloaded to ${WORKSPACE}/ComfyUI/models/text_encoders"
    "https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/text_encoders/umt5_xxl_fp16.safetensors?download=true"
)

CLIP_MODELS=(
    # "model url to be downloaded to ${WORKSPACE}/ComfyUI/models/clip"
)

CLIP_VISION_MODELS=(
    # "model url to be downloaded to ${WORKSPACE}/ComfyUI/models/clip_vision"
    "https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/clip_vision/clip_vision_h.safetensors?download=true"
)

ESRGAN_MODELS=(
    # "model url to be downloaded to ${WORKSPACE}/ComfyUI/models/esrgan"
)

CONTROLNET_MODELS=(
    # "model url to be downloaded to ${WORKSPACE}/ComfyUI/models/controlnet"
)

WAV2VEC2_MODELS=(
    # "model url to be downloaded to ${WORKSPACE}/ComfyUI/models/wav2vec2"
    "https://huggingface.co/Kijai/wav2vec2_safetensors/resolve/main/wav2vec2-chinese-base_fp16.safetensors?download=true"
)

### DO NOT EDIT BELOW HERE UNLESS YOU KNOW WHAT YOU ARE DOING ###

function provisioning_start() {
    provisioning_print_header
    provisioning_get_apt_packages
    provisioning_get_default_workflow
    provisioning_lora_folders
    provisioning_get_comfyui_nodes
    provisioning_get_pip_packages
    provisioning_get_models \
        "${WORKSPACE}/ComfyUI/models/ckpt" \
        "${CKPT_MODELS[@]}"
    provisioning_get_models \
        "${WORKSPACE}/ComfyUI/models/unet" \
        "${UNET_MODELS[@]}"
    provisioning_get_models \
        "${WORKSPACE}/ComfyUI/models/loras" \
        "${LORA_MODELS[@]}"
    provisioning_get_models \
        "${WORKSPACE}/ComfyUI/models/controlnet" \
        "${CONTROLNET_MODELS[@]}"
    provisioning_get_models \
        "${WORKSPACE}/ComfyUI/models/vae" \
        "${VAE_MODELS[@]}"
	provisioning_get_models \
        "${WORKSPACE}/ComfyUI/models/text_encoders" \
        "${TEXT_ENCODERS[@]}"
	provisioning_get_models \
        "${WORKSPACE}/ComfyUI/models/diffusion_models" \
        "${DIFFUSION_MODELS[@]}"
    provisioning_get_models \
        "${WORKSPACE}/ComfyUI/models/clip" \
        "${CLIP_MODELS[@]}"
    provisioning_get_models \
        "${WORKSPACE}/ComfyUI/models/clip_vision" \
        "${CLIP_VISION_MODELS[@]}"
    provisioning_get_models \
        "${WORKSPACE}/ComfyUI/models/esrgan" \
        "${ESRGAN_MODELS[@]}"
    provisioning_get_models \
        "${WORKSPACE}/ComfyUI/models/wav2vec2" \
        "${WAV2VEC2_MODELS[@]}"

    provisioning_print_end
}

function pip_install() {
    uv pip install "$@"
}

function provisioning_get_apt_packages() {
    if [[ -n $APT_PACKAGES ]]; then
            sudo apt install -y ${APT_PACKAGES[@]}
    fi
}

function provisioning_get_pip_packages() {
    if [[ -n $PIP_PACKAGES ]]; then
            pip_install ${PIP_PACKAGES[@]}
    fi
}

function provisioning_get_comfyui_nodes() {
    for repo in "${COMFYUI_NODES[@]}"; do
        dir="${repo##*/}"
        path="${WORKSPACE}/ComfyUI/custom_nodes/${dir}"
        requirements="${path}/requirements.txt"
        if [[ -d $path ]]; then
            if [[ ${AUTO_UPDATE,,} != "false" ]]; then
                printf "Updating node: %s...\n" "${repo}"
                ( cd "$path" && git pull )
                if [[ -e $requirements ]]; then
                   pip_install -r "$requirements"
                fi
            fi
        else
            printf "Downloading node: %s...\n" "${repo}"
            git clone "${repo}" "${path}" --recursive
            if [[ -e $requirements ]]; then
                pip_install -r "${requirements}"
            fi
        fi
    done
}

function provisioning_get_default_workflow() {
    if [[ -n $DEFAULT_WORKFLOW ]]; then
        workflow_json=$(curl -s "$DEFAULT_WORKFLOW")
        if [[ -n $workflow_json ]]; then
            echo "export const defaultGraph = $workflow_json;" > ${WORKSPACE}/ComfyUI/web/scripts/defaultGraph.js
        fi
    fi
}

function provisioning_get_models() {
    if [[ -z $2 ]]; then return 1; fi
    
    dir="$1"
    mkdir -p "$dir"
    shift
    arr=("$@")
    printf "Downloading %s model(s) to %s...\n" "${#arr[@]}" "$dir"
    for url in "${arr[@]}"; do
        printf "Downloading: %s\n" "${url}"
        provisioning_download "${url}" "${dir}"
        printf "\n"
    done
}

function provisioning_print_header() {
    printf "\n##############################################\n"
    printf "\nProvisioning started...\n"
    source /venv/main/bin/activate
}

function provisioning_print_end() {
    printf "\nProvisioning complete: Web UI will start now\n"
    printf "\n##############################################\n"
}

function provisioning_has_valid_hf_token() {
    [[ -n "$HF_TOKEN" ]] || return 1
    url="https://huggingface.co/api/whoami-v2"

    response=$(curl -o /dev/null -s -w "%{http_code}" -X GET "$url" \
        -H "Authorization: Bearer $HF_TOKEN" \
        -H "Content-Type: application/json")

    # Check if the token is valid
    if [ "$response" -eq 200 ]; then
        return 0
    else
        return 1
    fi
}

function provisioning_has_valid_civitai_token() {
    [[ -n "$CIVITAI_TOKEN" ]] || return 1
    url="https://civitai.com/api/v1/models?hidden=1&limit=1"

    response=$(curl -o /dev/null -s -w "%{http_code}" -X GET "$url" \
        -H "Authorization: Bearer $CIVITAI_TOKEN" \
        -H "Content-Type: application/json")

    # Check if the token is valid
    if [ "$response" -eq 200 ]; then
        return 0
    else
        return 1
    fi
}

# Download from $1 URL to $2 file path
function provisioning_download() {
    if [[ -n $HF_TOKEN && $1 =~ ^https://([a-zA-Z0-9_-]+\.)?huggingface\.co(/|$|\?) ]]; then
        auth_token="$HF_TOKEN"
    elif 
        [[ -n $CIVITAI_TOKEN && $1 =~ ^https://([a-zA-Z0-9_-]+\.)?civitai\.com(/|$|\?) ]]; then
        auth_token="$CIVITAI_TOKEN"
    fi
    if [[ -n $auth_token && $1 =~ ^https://([a-zA-Z0-9_-]+\.)?huggingface\.co(/|$|\?) ]]; then
        final_url=$(curl -H "Authorization: Bearer $auth_token" -s -L -I -w '%{url_effective}' -o /dev/null "$1")
        filename=$(curl -H "Authorization: Bearer $auth_token" -s -L -I "$final_url" | grep -i 'content-disposition' | sed -n 's/.*filename\*=UTF-8''//;s/.*filename="//;s/";//p')
        aria2c -x 16 -s 16 -k 10M -c --file-allocation=falloc --header="Authorization: Bearer $auth_token" --dir="$2" -o "$filename" "$final_url"
    elif 
        [[ -n $auth_token && $1 =~ ^https://([a-zA-Z0-9_-]+\.)?civitai\.com(/|$|\?) ]]; then
        final_url=$(curl -H "Authorization: Bearer $auth_token" -s -L -I -w '%{url_effective}' -o /dev/null "$1")
        aria2c -x 16 -s 16 -k 10M -c --file-allocation=falloc --dir="$2" "$final_url"
    fi
}

provisioning_start
