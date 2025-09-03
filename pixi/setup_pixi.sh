PIXI_DIR="${1:-.pixi}"
PIXI_INSTALL="${2:--a}"

curl -fLsS https://pixi.sh/install.sh | PIXI_HOME="${HOME}/${PIXI_DIR}" PIXI_NO_PATH_UPDATE=1 sh
echo $'\nexport CONDA_OVERRIDE_CUDA=12' >> ~/.bashrc
echo 'export PIXI_HOME="${HOME}/'"${PIXI_DIR}"'"' >> ~/.bashrc
echo 'export PATH="${PIXI_HOME}/bin:${PATH}"' >> ~/.bashrc
echo 'export PIXI_CACHE_DIR="${PIXI_HOME}/rattler"' >> ~/.bashrc
echo 'eval "$(pixi completion -s bash)"' >> ~/.bashrc
echo 'alias update-pixi='\''pixi self-update && pixi g s && pixi g update && pixi update && pixi i '"${PIXI_INSTALL}"' && pixi clean cache --build --build-backends --exec --mapping --repodata && pixi r export'\' >> ~/.bash_aliases
echo 'alias kill-pixi='\''ps aux | grep -E " pixi($| )|/.pixi/(bin|envs)/" | grep -v grep | tee /dev/tty | awk "{print \$2}" | xargs -rt kill; sleep 1; ps aux | grep -E " pixi($| )|/.pixi/(bin|envs)/" | grep -v grep | tee /dev/tty | awk "{print \$2}" | xargs -rt kill -9'\' >> ~/.bash_aliases
echo 'alias clean-pixi-global='\''echo "version = 1" > "${PIXI_HOME}/manifests/pixi-global.toml" && pixi g s'\' >> ~/.bash_aliases
echo 'alias clean-pixi='\''kill-pixi; clean-pixi-global; pixi clean; pixi clean cache -y'\' >> ~/.bash_aliases
. ~/.bashrc
pixi config set -g detached-environments "${PIXI_HOME}/envs"
pixi config ls
pixi info -vvv
