#!/bin/bash
#SBATCH -J 3dgs-truck-test
#SBATCH -o logs/truck-test.%j.out
#SBATCH -t 01:30:00
#SBATCH -p titanxp
#SBATCH --gres=gpu:1
#SBATCH --mem=16G

# Slurm 시스템 정보 출력
echo "[INFO] CUDA_VISIBLE_DEVICES=$CUDA_VISIBLE_DEVICES"
echo "[INFO] SLURM_JOB_ID: $SLURM_JOB_ID"

# Conda 환경 설정
source $HOME/miniconda3/etc/profile.d/conda.sh
conda activate gaussian_splatting

# 🔧 conda CUDA 우선 적용 (핵심 해결)
export LD_LIBRARY_PATH=$CONDA_PREFIX/lib:$LD_LIBRARY_PATH
export CUDA_LAUNCH_BLOCKING=1

# 작업 디렉토리 이동
cd /home/rlatnsgh0708/research_project/gaussian-splatting

# 학습 실행
python train.py -s data/tandt/truck --iterations 1000 --save_iterations 1000 -r 4

conda deactivate
echo "=== JOB FINISHED ==="
