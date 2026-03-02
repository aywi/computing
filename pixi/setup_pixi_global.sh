#!/bin/bash -e
# Set up Pixi global tools
# Usage: . setup_pixi_global.sh

clean-pixi-global
pixi g i -e gnu gcc gdb gfortran gxx make
pixi g i -e tools pip python=3.13
pixi g a -e tools byobu --expose byobu
pixi g a -e tools cmake --expose ccmake --expose cmake --expose cpack --expose ctest
pixi g a -e tools conda conda-recipe-manager conda-smithy --expose conda
pixi g a -e tools git git-lfs --expose git --expose gitk
pixi g a -e tools gojq --expose gojq
pixi g a -e tools htop --expose htop
pixi g a -e tools jaq --expose jaq
pixi g a -e tools jq --expose jq
pixi g a -e tools mamba --expose mamba
pixi g a -e tools micromamba --expose micromamba
pixi g a -e tools nvitop --expose nvisel --expose nvitop
pixi g a -e tools nvtop --expose nvtop
pixi g a -e tools tmux!=3.6 --expose tmux
pixi g a -e tools uv --expose uv --expose uvx
pixi g ls
