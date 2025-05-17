#!/bin/bash
#SBATCH --job-name=convert_colmap
#SBATCH --output=logs/convert_%j.out
#SBATCH --partition=titanxp
#SBATCH --gres=gpu:1
#SBATCH --time=01:00:00
#SBATCH --mem=16G

# Slurm 시스템 정보 출력
echo "[INFO] CUDA_VISIBLE_DEVICES=$CUDA_VISIBLE_DEVICES"
echo "[INFO] SLURM_JOB_ID: $SLURM_JOB_ID"

# 1. Conda 환경 활성화
source $HOME/miniconda3/etc/profile.d/conda.sh
conda activate gaussian_splatting

# 🔧 conda CUDA 우선 적용 (핵심 해결)
export LD_LIBRARY_PATH=$CONDA_PREFIX/lib:$LD_LIBRARY_PATH

# 작업 디렉토리 이동
cd /home/rlatnsgh0708/research_project/gaussian-splatting

# 3. convert.py 실행
python convert.py -s data/tandt/truck

conda deactivate
echo "=== JOB FINISHED ==="