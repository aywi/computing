read -p "Do you want to use CERNET mirrors? (yes/no) " use_cernet
conda config --set auto_activate_base True
conda config --remove-key channels
conda config --remove-key custom_channels
conda config --remove-key default_channels
if [ "${use_cernet}" == "yes" ]; then
    # https://mirrors.tuna.tsinghua.edu.cn/help/anaconda/
    # https://conda.io/projects/conda/en/latest/user-guide/configuration/use-condarc.html#set-a-channel-alias-channel-alias
    # https://mirrors.sustech.edu.cn/help/anaconda.html
    # https://help.mirrors.cernet.edu.cn/anaconda-extra/
    conda config --set channel_alias https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/
    conda config --set custom_channels.nvidia https://mirrors.sustech.edu.cn/anaconda-extra/cloud/
    conda config --append default_channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main/
    conda config --append default_channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/r/
    conda config --set show_channel_urls True
else
    conda config --remove-key channel_alias
    conda config --remove-key show_channel_urls
fi
conda config --show-sources
conda clean -i -y
conda update -n base -y conda
conda init bash
# https://github.com/conda/conda/issues/7980#issuecomment-441358406
# https://github.com/conda/conda/issues/7980#issuecomment-472648567
. $(conda info --base)/etc/profile.d/conda.sh
conda activate
conda install -y git gcc_linux-64 gxx_linux-64 gfortran_linux-64 pip python=3.12
if [ "${use_cernet}" == "yes" ]; then
    # https://mirrors.tuna.tsinghua.edu.cn/help/pypi/
    pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
    pip config list
else
    pip config unset global.index-url
fi
pip install -U arxiv-latex-cleaner edge-tts kaggle
conda clean -a -y
conda info
