# Ansible Playbook for Orches Workflow Replication

This Ansible playbook automates the deployment of the Orches Workflow to multiple repositories and organizations, requiring only a GitHub token.

## Prerequisites

1. **Ansible**: Install Ansible on your system
   ```bash
   # macOS
   brew install ansible
   
   # Ubuntu/Debian
   sudo apt install ansible
   
   # Python pip
   pip install ansible
   ```

2. **GitHub CLI**: Install and authenticate with GitHub CLI
   ```bash
   # Install gh CLI
   brew install gh  # macOS
   sudo apt install gh  # Ubuntu
   
   # Authenticate
   gh auth login
   ```

3. **GitHub Token**: Create a GitHub Personal Access Token with these permissions:
   - `repo` (full repository access)
   - `admin:org` (organization administration)
   - `project` (project management)
   - `workflow` (GitHub Actions workflows)

## Quick Start

1. **Set up environment**:
   ```bash
   export GITHUB_TOKEN="your_github_token_here"
   ```

2. **Copy and customize configuration files**:
   ```bash
   cp inventory.example.yml inventory.yml
   cp vars.example.yml vars.yml
   
   # Edit inventory.yml to set your organization
   # Edit vars.yml to define your repositories
   ```

3. **Run the playbook**:
   ```bash
   ansible-playbook -i inventory.yml -e @vars.yml replicate-workflow.yml
   ```

## Configuration

### Inventory File (`inventory.yml`)

```yaml
all:
  vars:
    github_token: "{{ lookup('env', 'GITHUB_TOKEN') }}"
    github_org: "your-org-name"
    github_project_number: 1
  hosts:
    localhost:
      ansible_connection: local
```

### Variables File (`vars.yml`)

```yaml
repositories:
  - name: "my-app"
    private: true
  - name: "my-api"
    private: false

additional_labels:
  - name: "priority:high"
    color: "d73a4a"
    description: "High priority item"
```

## What the Playbook Does

### For Each Repository:

1. **Creates repository** (if it doesn't exist)
2. **Sets up labels** for AI workflow management
3. **Installs GitHub Actions workflows**:
   - PR scope validation
   - Documentation link enforcement
   - Branch protection rules
4. **Configures branch protection** for main branch
5. **Creates templates**:
   - Pull request template
   - Issue templates
6. **Sets up project integration**

### Organization-wide:

1. **Installs CLI extensions** (`gh-dy`, `gh-dy-admin`)
2. **Configures project fields** for AI agent tracking
3. **Generates setup report**

## Advanced Usage

### Target Specific Environment

```bash
# Development environment
ansible-playbook -i inventory.yml -e @vars.yml replicate-workflow.yml --limit development

# Production environment
ansible-playbook -i inventory.yml -e @vars.yml replicate-workflow.yml --limit production
```

### Override Variables

```bash
# Override organization
ansible-playbook -i inventory.yml -e @vars.yml -e github_org=different-org replicate-workflow.yml

# Skip certain steps
ansible-playbook -i inventory.yml -e @vars.yml -e skip_branch_protection=true replicate-workflow.yml
```

### Dry Run Mode

```bash
# Check what would be changed without making changes
ansible-playbook -i inventory.yml -e @vars.yml replicate-workflow.yml --check
```

## Customization

### Adding Custom Workflows

1. Place your custom workflow files in the same directory as the playbook
2. Add them to `vars.yml`:
   ```yaml
   additional_workflows:
     - src: "my-custom-workflow.yml"
       dest: "my-custom-workflow.yml"
       description: "My custom CI/CD pipeline"
   ```

### Custom Labels

Add organization-specific labels in `vars.yml`:
```yaml
additional_labels:
  - name: "team:frontend"
    color: "1f883d"
    description: "Frontend team responsibility"
```

### Branch Protection Customization

Modify branch protection rules in `vars.yml`:
```yaml
branch_protection:
  required_status_checks:
    contexts:
      - "validate"
      - "validate-links"
      - "my-custom-check"
  required_pull_request_reviews:
    required_approving_review_count: 2
```

## Troubleshooting

### Common Issues

1. **Authentication Errors**:
   ```bash
   # Verify token is set
   echo $GITHUB_TOKEN
   
   # Test GitHub CLI authentication
   gh auth status
   ```

2. **Permission Errors**:
   - Ensure your GitHub token has all required permissions
   - Verify you have admin access to the organization

3. **Repository Creation Fails**:
   - Check if repository name already exists
   - Verify organization name is correct

4. **Workflow Installation Fails**:
   - Ensure repository has Actions enabled
   - Check if workflow files already exist

### Debug Mode

Run with verbose output:
```bash
ansible-playbook -i inventory.yml -e @vars.yml replicate-workflow.yml -vvv
```

### Partial Recovery

If the playbook fails partway through, you can:

1. **Skip completed repositories** by removing them from `vars.yml`
2. **Re-run specific tasks** using tags (if implemented)
3. **Check the setup report** for what was completed

## Security Considerations

1. **Token Security**:
   - Never commit GitHub tokens to version control
   - Use environment variables or secure vaults
   - Rotate tokens regularly

2. **Repository Access**:
   - Review what repositories the playbook will modify
   - Test on a small set first
   - Use separate tokens for different environments

3. **Branch Protection**:
   - The playbook sets up branch protection rules
   - Review these rules before applying to production

## Integration with CI/CD

### GitHub Actions Integration

You can run this playbook from GitHub Actions:

```yaml
name: Deploy Orches Workflow
on:
  workflow_dispatch:
    inputs:
      target_org:
        description: 'Target organization'
        required: true

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Setup Ansible
        run: pip install ansible
      - name: Run playbook
        run: |
          cd ansible
          ansible-playbook -i inventory.yml -e @vars.yml -e github_org=${{ github.event.inputs.target_org }} replicate-workflow.yml
        env:
          GITHUB_TOKEN: ${{ secrets.ADMIN_GITHUB_TOKEN }}
```

### Terraform Integration

The playbook can complement Terraform for infrastructure:

```hcl
resource "null_resource" "orches_workflow" {
  provisioner "local-exec" {
    command = "cd ansible && ansible-playbook -i inventory.yml -e @vars.yml replicate-workflow.yml"
    environment = {
      GITHUB_TOKEN = var.github_token
    }
  }
  
  depends_on = [github_repository.repos]
}
```

## Support

For issues and questions:

1. Check the [main repository](https://github.com/buihongduc132/orches-workflow) documentation
2. Review the setup report generated by the playbook
3. Open an issue with detailed error messages and configuration
