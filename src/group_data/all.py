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
        "vim-autopep8",
        "httpie",
        "bat",
        "zsh",
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
    {
        'name': "Install lsd",
        'packages': "lsd",
        '_sudo': True,
        'type': 'snap',
    },
]

script_packages = {
    "debian": [
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
            'name': 'LunarVim',
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

