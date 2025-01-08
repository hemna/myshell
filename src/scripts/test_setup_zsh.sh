#!/bin/bash
#

# Look for starship setup in ~/.local.zsh
if grep -q "starship init zsh" ~/.local.zsh
then
    echo "starship setup already in ~/.local.zsh"
else
    echo 'eval "$(starship init zsh)"' >> ~/.local.zsh
fi
