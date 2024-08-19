read -p "Do you want to remove Miniconda? (yes/no) " remove_miniconda
if [ "${remove_miniconda}" == "yes" ]; then
    read -p "Do you want to remove the settings of Miniconda? (yes/no) " remove_miniconda_settings
    conda init --reverse
    rm -frv ~/miniconda3
    rm -frv ~/.conda
    if [ "${remove_miniconda_settings}" == "yes" ]; then
        rm -fv ~/.condarc
    fi
fi
