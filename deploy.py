from pyinfra import host
from pyinfra.operations import apt, server, git, pip, brew, snap
from pyinfra.facts import server as server_facts

from rich.console import Console

from utils import git_clone_or_pull, link

cs = Console()


# Define some state - this operation will do nothing on subsequent runs
user = host.get_fact(server_facts.User)
#cs.print_json(data=user)
home = host.get_fact(server_facts.Home)
#cs.print_json(data=home)
#cs.print(host.data.bin_packages)
cs.print(f"User = {host.data.get('ssh_user')}")
cs.print(f"OS VERSION = {host.get_fact(server_facts.Os)}")



# First install binary packages
def install_binaries():
    if host.get_fact(server_facts.LinuxName) in ["Debian", "Ubuntu"]:
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
            
            
    elif host.get_fact(server_facts.Os) in ["Darwin"]:
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



# Install any python packages
def install_python_packages():
    pip.packages(
        name="Install required python packages",
        packages=host.data.python_packages,
        present=True,
        latest=True,
    )


def install_dotfiles():
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






install_binaries()
install_python_packages()
install_dotfiles()
