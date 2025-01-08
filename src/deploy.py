from pyinfra import host, logger
from pyinfra.operations import apt, server, git, pip, brew, snap
from pyinfra.facts import server as server_facts

from rich.console import Console

from utils import git_clone_or_pull, link

cs = Console()

# Define some state - this operation will do nothing on subsequent runs
user = host.get_fact(server_facts.User)
logger.info(f"user = {user}")
home = host.get_fact(server_facts.Home)
#cs.print_json(data=home)
#cs.print(host.data.bin_packages)
logger.info(f"User = {host.data.get('ssh_user')}")
logger.info(f"OS VERSION = {host.get_fact(server_facts.Os)}")


def install_debian_binaries(cs):
    with cs.status("Installing Debian Binaries") as status:
        logger.info(f"Packages to install {host.data.bin_packages['debian']}")
        apt.update(
                name="Update apt repositories",
                cache_time=3600,
                _sudo=True,
            )
        apt.upgrade(name="Update apt packages", _sudo=True)
        apt.packages(
            name="Install required packages",
            packages=host.data.bin_packages["debian"],
            update=True,
            _sudo=True,
        )
        
        # Now install all shell packages
        logger.info(f"Installing debian script packages {len(host.data.script_packages['debian'])}")
        for entry in host.data.script_packages["debian"]:
            server.shell(
                name=entry['name'],
                commands=entry['commands'],
                _sudo=entry.get('_sudo', False)
            )
        logger.info(f"Installing common script packages {len(host.data.script_packages['all'])}")
        for entry in host.data.script_packages["all"]:
            server.shell(
                name=entry['name'],
                commands=entry['commands'],
                _sudo=entry.get('_sudo', False)
            )
            
        # Now install all snap packages
        for entry in host.data.snap_packages:
            snap.package(
                name=entry['name'],
                packages=entry['packages'],
                _sudo=entry.get('_sudo', False)
            )


def install_macos_binaries(cs):
    with cs.status("Install MacOS Binaries") as status:
        brew.update(name="Update brew")
        brew.upgrade(name="Upgrade brew")
        brew.cask_upgrade(name="Upgrade brew casks")
        brew.casks(
            name="Install GQRX",
            casks=["gqrx"],
            present=True,
            latest=True,
        )
        brew.packages(
            name="Install starship prompt",
            packages=["starship"],
            present=True,
            latest=True,
            update=True,
            upgrade=True
        )
        brew.packages(
            name="Install LSD",
            packages=["lsd"],
            latest=True,
            upgrade=True,
            update=True,
            present=True,
        ) 


# First install binary packages
def install_binaries(cs):
    if host.get_fact(server_facts.LinuxName) in ["Debian", "Ubuntu"]:
        install_debian_binaries(cs)
    elif host.get_fact(server_facts.Os) in ["Darwin"]:
        install_macos_binaries(cs)
        

# Install any python packages
def install_python_packages(cs):
    pip.packages(
        name="Install required python packages",
        packages=host.data.python_packages,
        present=True,
        latest=True,
    )


def install_dotfiles(cs):
    git_clone_or_pull(
        src="https://github.com/robbyrussell/oh-my-zsh.git",
        dest=f"{home}/.oh-my-zsh",
        user=host.data.get("ssh_user"),
        update_submodules=True,
        recursive_submodules=True,
    ) 
    
    
    # Clone my dotfiles repo
    git.repo(
        name="Clone the Dotfiles repo",
        src="https://github.com/hemna/.dotfiles.git",
        dest=f"{home}/.dotfiles",
        user=host.data.get("ssh_user"),
    )

    #server.shell(
    #    name="Run the dotfiles install script",
    #    commands=[f"{home}/.dotfiles/setup.sh"],
    #    #user=host.data.get("ssh_user"),
    #)

    server.shell(
        name="Install iterm2 shell integration",
        commands=["curl -L https://iterm2.com/shell_integration/install_shell_integration.sh | bash"],
    )

    server.script(
        name="Enable Starship Prompt",
        src="scripts/test_setup_zsh.sh"
    )

    server.shell(
        name="Install the vim setup",
        commands=["curl -sLf https://spacevim.org/install.sh | bash"],
    )

    server.shell(
        name="Setup dotfiles links",
        commands=[f"{home}/.dotfiles/link.sh"]
    )



install_binaries(cs)
install_python_packages(cs)
install_dotfiles(cs)
