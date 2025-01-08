bin_packages = {
    "debian": [
        "build-essential",
        "autoconf",
        "automake",
        "direnv",
        "libtool",
        "lnav",
        "lsb-release",
        "python3-autopep8",
        "python3-venv",
        "vim-autopep8",
        "httpie",
        "bat",
        "zsh",
        "lsd",
        "neovim",
    ],
    "macos" : [
        "coreutils",
        "python",
        "pip-completion",
        "lsd",
        "neovim",
    ],
}

# snap is basically debian only
snap_packages = [
]

script_packages = {
    "debian": [
        # {
        #     'name': "Install neovim",
        #     'commands': ['curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz',
        #                  'rm -rf /opt/nvim',
        #                  'tar -C /opt -xzf nvim-linux64.tar.gz',
        #                  'ln -s /opt/nvim-linux64/bin/nvim /usr/local/bin'],
        #     '_sudo': True,
        # },
    ],
    "macos": [
    ],
    "all": [
        {
            'name': "Install starship prompt",
            'commands': ["curl -sS https://starship.rs/install.sh | sh -s -- --yes"],
            '_sudo': True,
        },
        {
            'name': 'Install LunarVim',
            'commands': ['LV_BRANCH="release-1.4/neovim-0.9" curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.4/neovim-0.9/utils/installer/install.sh | bash'],
            '_sudo': True,
        }
    ]
}


python_packages = [
    "virtualfish",
    "glances",
    "thefuck",
    "xonsh",
    "pipx",
]

