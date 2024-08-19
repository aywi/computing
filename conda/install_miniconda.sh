rm -fv ./Miniconda3-latest-Linux-x86_64.sh
read -p "Do you want to use CERNET mirrors? (yes/no) " use_cernet
cat /etc/*release*
if [ "${use_cernet}" == "yes" ]; then
    # https://mirrors.tuna.tsinghua.edu.cn/help/anaconda/
    wget https://mirrors.tuna.tsinghua.edu.cn/anaconda/miniconda/Miniconda3-latest-Linux-x86_64.sh
else
    # https://docs.conda.io/projects/miniconda/en/latest/
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
fi
bash ./Miniconda3-latest-Linux-x86_64.sh
rm -fv ./Miniconda3-latest-Linux-x86_64.sh
. ~/.bashrc
