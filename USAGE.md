# Usage Guide - Orches Workflow

## Overview

The Orches Workflow provides tools and processes for AI-first GitHub collaboration. This guide covers how to use the various components once they're set up.

## CLI Extensions

### gh-dy (Day-to-Day Operations)

The `gh-dy` extension provides commands for daily workflow operations:

#### Task Management
```bash
# Create a new task/issue
gh dy task create "Implement user authentication"

# Claim an existing task
gh dy task claim 123

# Update task progress
gh dy task progress 123

# Block a task (mark as blocked)
gh dy task block 123

# Submit task for review
gh dy task review 123

# Close completed task
gh dy task close 123

# Link task to other issues/PRs
gh dy task link 123 456

# Add task to project board
gh dy task add-to-project 123
```

#### Dashboard Views
```bash
# View AI agent dashboard
gh dy dashboard agent

# View items needing human review
gh dy dashboard review

# View blocked items
gh dy dashboard blocked

# View cross-component issues
gh dy dashboard xcomp
```

#### Triage Operations
```bash
# Auto-triage new issues
gh dy triage auto

# Assign issues to team members
gh dy triage assign

# Handle stale issues
gh dy triage stale
```

#### PR Operations
```bash
# Wait for PR checks to complete
gh dy pr await

# Queue PR for merge
gh dy pr queue

# Check PR status
gh dy pr checks

# Convert to draft PR
gh dy pr draft

# Merge if all checks pass
gh dy pr merge-if-green
```

#### Discussion Management
```bash
# Start feature discussion
gh dy discuss feature "New authentication system"

# Add comment to discussion
gh dy discuss comment 123 "Additional thoughts..."

# Link discussions to issues
gh dy discuss link 123 456
```

#### Workflow Information
```bash
# Describe current workflow
gh dy workflow describe

# Provide feedback
gh dy feedback
```

### gh-dy-admin (Administrative Operations)

The `gh-dy-admin` extension handles setup and administrative tasks:

#### Setup Commands
```bash
# Setup entire project
gh dy-admin setup project

# Setup labels only
gh dy-admin setup labels

# Setup GitHub Actions templates
gh dy-admin setup templates

# Setup repository configuration
gh dy-admin setup repo

# Setup discussions
gh dy-admin setup discussions
```

#### Project Management
```bash
# Ensure project fields exist
gh dy-admin project ensure-fields

# Check project status
gh dy-admin project status
```

#### Label Management
```bash
# Ensure all required labels exist
gh dy-admin label ensure
```

#### Template Management
```bash
# Setup issue templates
gh dy-admin template issues

# Setup PR templates
gh dy-admin template prs
```

## Bootstrap Scripts

### Label Setup
```bash
# Create standardized labels for a repository
./scripts/labels-ensure.sh owner/repo
```

This creates the following labels:
- `ai-task`: Task for AI agents
- `human-review-needed`: Needs human attention
- `cross-component`: Spans multiple components
- `status:ai-review`: AI review stage
- `status:ai-test`: AI test stage
- `status:ai-approved`: AI approved stage

### Project Field Setup
```bash
# Setup project fields
./scripts/project-ensure-fields.sh owner project_number
```

This creates:
- "AI Agent" text field for tracking which AI agent is working on items

## GitHub Actions Templates

### PR Scope Validation

The `validate-pr-scope.yml` template enforces:

1. **File Path Restrictions**: Only allows changes to specific directories in super repositories
2. **Linked PR Requirements**: Requires "Linked PR:" in PR body when bumping submodules
3. **Scope Enforcement**: Prevents mixing super and submodule changes

To use in your repository:
```bash
# Copy the template to your .github/workflows/ directory
cp templates/rules/validate-pr-scope.yml .github/workflows/
```

## Workflow Principles

### PR Requirements

All PRs must:
1. **Link to Documentation**: Include references to relevant wiki pages, docs, or issues
2. **Proper Scope**: Stay within defined boundaries (super vs sub repository changes)
3. **AI Agent Tracking**: Include AI agent information in project fields
4. **Human Review**: Pass through appropriate review stages

### Example PR Body Template
```markdown
## Description
Brief description of changes

## Linked Documentation
- Wiki: [Page Title](link-to-wiki)
- Issue: #123
- Related PR: #456

## AI Agent
Agent: GPT-4-Turbo
Stage: ai-review

## Checklist
- [ ] Tests pass
- [ ] Documentation updated
- [ ] Proper scope maintained
- [ ] Links verified
```

### Repository Targeting

Most commands support the `--repo` flag to target specific repositories:
```bash
gh dy task create "Fix bug" --repo owner/repo
gh dy-admin setup labels --repo owner/repo
```

If omitted, commands auto-detect the current repository.

## Integration with Existing Workflows

The Orches Workflow is designed to complement existing GitHub workflows:

1. **Existing Labels**: Preserves existing labels while adding AI-specific ones
2. **Project Integration**: Works with existing GitHub Projects
3. **Action Compatibility**: GitHub Actions templates can coexist with existing workflows
4. **CLI Extension**: Extends `gh` CLI without replacing existing functionality

## Troubleshooting

### Common Issues

1. **Extension Not Found**: Ensure extensions are installed via `gh extension install`
2. **Permission Errors**: Verify GitHub token has appropriate repository permissions
3. **Repository Detection**: Use `--repo owner/repo` flag if auto-detection fails
4. **Label Conflicts**: Existing labels with same names will be preserved

### Getting Help

```bash
# Get help for main extension
gh dy --help

# Get help for admin extension
gh dy --help-admin

# Get help for specific commands
gh dy task --help
gh dy-admin setup --help
```
