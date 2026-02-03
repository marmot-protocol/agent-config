#!/bin/bash

set -e

CONFIG_DIR="${HOME}/.config/opencode"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR="${SCRIPT_DIR}/opencode"

usage() {
    echo "Usage: $0 [component]"
    echo ""
    echo "Install OpenCode configuration components."
    echo ""
    echo "Components:"
    echo "  agents     Install all agents"
    echo "  commands   Install all commands"
    echo "  plugins    Install all plugins"
    echo "  skills     Install all skills"
    echo "  tools      Install all tools"
    echo "  all        Install everything (default)"
    echo ""
    echo "Examples:"
    echo "  $0              # Install everything"
    echo "  $0 skills       # Install only skills"
    echo "  $0 commands     # Install only commands"
    exit 1
}

check_exists() {
    local dest="$1"
    local name="$2"
    if [[ -e "$dest" ]]; then
        echo "Warning: $name already exists at $dest"
        read -p "Overwrite? [y/N] " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            echo "Skipping $name"
            return 1
        fi
    fi
    return 0
}

install_files() {
    local src_dir="$1"
    local dest_dir="$2"
    local type="$3"

    if [[ ! -d "$src_dir" ]]; then
        echo "No $type found to install"
        return
    fi

    mkdir -p "$dest_dir"

    for file in "$src_dir"/*; do
        [[ -e "$file" ]] || continue
        local name=$(basename "$file")
        local dest="$dest_dir/$name"
        
        if check_exists "$dest" "$type/$name"; then
            if [[ -d "$file" ]]; then
                cp -r "$file" "$dest"
            else
                cp "$file" "$dest"
            fi
            echo "Installed $type/$name"
        fi
    done
}

install_agents() {
    install_files "$SOURCE_DIR/agents" "$CONFIG_DIR/agents" "agents"
}

install_commands() {
    install_files "$SOURCE_DIR/commands" "$CONFIG_DIR/commands" "commands"
}

install_plugins() {
    install_files "$SOURCE_DIR/plugins" "$CONFIG_DIR/plugins" "plugins"
}

install_skills() {
    install_files "$SOURCE_DIR/skills" "$CONFIG_DIR/skills" "skills"
}

install_tools() {
    install_files "$SOURCE_DIR/tools" "$CONFIG_DIR/tools" "tools"
}

install_all() {
    echo "Installing all components to $CONFIG_DIR"
    echo ""
    install_agents
    install_commands
    install_plugins
    install_skills
    install_tools
    echo ""
    echo "Done!"
}

# Main
COMPONENT="${1:-all}"

case "$COMPONENT" in
    agents)   install_agents ;;
    commands) install_commands ;;
    plugins)  install_plugins ;;
    skills)   install_skills ;;
    tools)    install_tools ;;
    all)      install_all ;;
    -h|--help) usage ;;
    *)
        echo "Unknown component: $COMPONENT"
        usage
        ;;
esac
