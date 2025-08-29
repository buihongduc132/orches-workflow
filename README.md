# orches-workflow

Centralized repository for AI-first GitHub workflow:
- Safeguard rules and GitHub Actions policies
- gh CLI extensions: `gh-dy` (day-to-day) and `gh-dy-admin` (admin/setup) — fully functional
- Bootstrap scripts to set labels, project fields, and dashboards
- Plans and docs for organization-wide adoption
- Ansible automation for easy replication across organizations

## Quick Start

### For AI Agents
```bash
# Get comprehensive AI instructions
gh dy ai-instructions

# Create and work on tasks
gh dy task create "Your task description"
gh dy task claim ISSUE_NUMBER

# Check workflow status
gh dy workflow describe
```

### For Humans
```bash
# Setup repository
gh dy-admin setup repo

# Check project status
gh dy-admin project status

# View available commands
gh dy --help
gh dy-admin --help
```

## AI Instructions

If you're an AI agent working with this repository, run:
```bash
gh dy ai-instructions
```

This command provides comprehensive instructions on:
- Workflow principles and requirements
- Available commands and usage
- PR creation and review process
- Common patterns and examples
- Error handling and troubleshooting

## Installation

### CLI Extensions
```bash
# Install from this repository
gh extension install ./extensions/gh-dy
gh extension install ./extensions/gh-dy-admin

# Or install from GitHub (when published)
gh extension install buihongduc132/gh-dy
gh extension install buihongduc132/gh-dy-admin
```

### Organization-wide Deployment
```bash
# Using Ansible (requires only GitHub token)
export GITHUB_TOKEN="your_token"
cd ansible
cp inventory.example.yml inventory.yml
cp vars.example.yml vars.yml
# Edit configuration files
ansible-playbook -i inventory.yml -e @vars.yml replicate-workflow.yml
```

## Documentation

- [Quick Reference](QUICK_REFERENCE.md) - Project navigation and structure
- [Usage Guide](USAGE.md) - Detailed usage instructions
- [Setup Guide](SETUP.md) - Installation and configuration
- [Project Info](flow/project_info.md) - Project metadata and overview
- [Implementation Plan](flow/plans/IMPLEMENTATION_PLAN.md) - Detailed roadmap

