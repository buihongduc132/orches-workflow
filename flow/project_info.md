---
id: orches-workflow
summary: Centralized repository for AI-first GitHub workflow with safeguard rules, CLI extensions, and organization-wide adoption tools
tech_stack: 
  - Bash scripting
  - GitHub Actions (YAML)
  - GitHub CLI extensions
  - Ansible (for replication)
  - Git workflows
status: active
created: 2025-08-29
---

# Project Information

## Overview
The orches-workflow project provides a comprehensive AI-first GitHub workflow system designed for organization-wide adoption. It includes safeguard policies, CLI extensions, and automation tools to ensure proper PR management and AI-human collaboration.

## Key Components

### 1. Safeguard Rules (`templates/rules/`)
- **validate-pr-scope.yml**: GitHub Action that enforces PR scope validation
- Prevents mixing super/submodule changes in single PRs
- Requires linked PRs for submodule bumps
- Enforces file path restrictions

### 2. CLI Extensions (`extensions/`)
- **gh-dy**: Day-to-day workflow commands
  - Task management (create, claim, progress, review, close)
  - Dashboards (agent, review, blocked, cross-component)
  - Triage automation
  - PR operations
- **gh-dy-admin**: Administrative setup commands
  - Project and label setup
  - Template management
  - Repository configuration

### 3. Bootstrap Scripts (`scripts/`)
- **labels-ensure.sh**: Creates standardized AI workflow labels
- **project-ensure-fields.sh**: Sets up project fields for AI agent tracking

### 4. Workflow Requirements
- All code changes must go through PRs
- PRs must link to relevant documentation, issues, or tasks
- AI-first approach with human review checkpoints
- Proper scope separation between super and sub repositories

## Goals
1. Standardize AI-first GitHub workflows across organization
2. Ensure proper separation of concerns in multi-repo setups
3. Provide tooling for efficient AI-human collaboration
4. Enable easy replication across different projects and organizations
