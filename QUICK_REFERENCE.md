# Quick Reference - Orches Workflow

## Project Structure

```
orches-workflow/
├── README.md                           # Main project overview
├── QUICK_REFERENCE.md                  # This file - quick navigation
├── USAGE.md                           # How to use the workflow tools
├── SETUP.md                           # Setup instructions
├── flow/                              # Project documentation and plans
│   ├── project_info.md               # Project metadata and overview
│   └── plans/                        # Detailed planning documents
│       └── WORKFLOW_OVERVIEW.md      # High-level workflow description
├── templates/                         # Reusable templates and policies
│   └── rules/                        # GitHub Actions safeguard rules
│       └── validate-pr-scope.yml     # PR scope validation workflow
├── scripts/                          # Bootstrap and setup scripts
│   ├── labels-ensure.sh              # Create standardized labels
│   └── project-ensure-fields.sh     # Setup project fields
├── extensions/                       # GitHub CLI extensions
│   ├── gh-dy/                       # Day-to-day workflow extension
│   │   └── gh-dy                    # Main executable
│   └── gh-dy-admin/                 # Admin/setup extension
│       └── gh-dy-admin              # Admin executable
└── ansible/                         # Ansible playbooks (to be created)
    └── replicate-workflow.yml       # Replication playbook
```

## Core Components

### 1. Safeguard Rules
- **Location**: `templates/rules/`
- **Purpose**: GitHub Actions that enforce workflow policies
- **Key File**: `validate-pr-scope.yml` - Prevents mixing super/sub repo changes

### 2. CLI Extensions
- **gh-dy**: Day-to-day operations
  - Task management
  - Dashboards and triage
  - PR operations
- **gh-dy-admin**: Setup and administration
  - Project configuration
  - Label and template management

### 3. Bootstrap Scripts
- **labels-ensure.sh**: Creates AI workflow labels
- **project-ensure-fields.sh**: Sets up project tracking fields

### 4. Documentation
- **flow/**: Project plans and documentation
- **README.md**: Main overview
- **USAGE.md**: Usage instructions
- **SETUP.md**: Setup guide

## Quick Commands

### Setup New Repository
```bash
# Run bootstrap scripts
./scripts/labels-ensure.sh owner/repo
./scripts/project-ensure-fields.sh owner project_number

# Install CLI extensions
gh extension install buihongduc132/gh-dy
gh extension install buihongduc132/gh-dy-admin
```

### Daily Workflow
```bash
# Task management
gh dy task create "Task description"
gh dy task claim ISSUE_NUMBER
gh dy task progress ISSUE_NUMBER

# Dashboard views
gh dy dashboard agent
gh dy dashboard review

# PR operations
gh dy pr await
gh dy pr merge-if-green
```

### Admin Operations
```bash
# Setup project
gh dy-admin setup project
gh dy-admin setup labels

# Ensure fields
gh dy-admin project ensure-fields
```

## Workflow Principles

1. **AI-First**: Designed for AI agent collaboration
2. **PR-Only**: All changes must go through pull requests
3. **Linked Documentation**: PRs must reference relevant docs/issues
4. **Scope Separation**: Clear boundaries between super/sub repositories
5. **Human Oversight**: Built-in review checkpoints

## Related Documentation

- [Project Info](flow/project_info.md) - Detailed project metadata
- [Workflow Overview](flow/plans/WORKFLOW_OVERVIEW.md) - High-level workflow description
- [Usage Guide](USAGE.md) - How to use the tools
- [Setup Guide](SETUP.md) - Installation and configuration
