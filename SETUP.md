# Setup Guide - Orches Workflow

## Prerequisites

Before setting up the Orches Workflow, ensure you have:

1. **GitHub CLI**: Install `gh` CLI tool
   ```bash
   # macOS
   brew install gh
   
   # Ubuntu/Debian
   sudo apt install gh
   
   # Windows
   winget install GitHub.cli
   ```

2. **GitHub Authentication**: Authenticate with GitHub
   ```bash
   gh auth login
   ```

3. **Repository Access**: Ensure your GitHub token has the following permissions:
   - `repo` (full repository access)
   - `project` (project management)
   - `admin:org` (for organization-wide setup)

## Installation Methods

### Method 1: Direct Installation (Recommended)

1. **Clone the Repository**
   ```bash
   git clone https://github.com/buihongduc132/orches-workflow.git
   cd orches-workflow
   ```

2. **Install CLI Extensions**
   ```bash
   # Install day-to-day extension
   gh extension install ./extensions/gh-dy
   
   # Install admin extension
   gh extension install ./extensions/gh-dy-admin
   ```

3. **Verify Installation**
   ```bash
   gh dy --help
   gh dy-admin --help
   ```

### Method 2: Remote Installation

```bash
# Install extensions directly from GitHub
gh extension install buihongduc132/gh-dy
gh extension install buihongduc132/gh-dy-admin
```

### Method 3: Ansible Automation (See Ansible section below)

## Repository Setup

### For New Repositories

1. **Initialize Repository**
   ```bash
   # Create new repository
   gh repo create my-org/my-repo --private
   cd my-repo
   ```

2. **Setup Labels**
   ```bash
   # Download and run label setup script
   curl -O https://raw.githubusercontent.com/buihongduc132/orches-workflow/main/scripts/labels-ensure.sh
   chmod +x labels-ensure.sh
   ./labels-ensure.sh my-org/my-repo
   ```

3. **Setup Project Fields** (if using GitHub Projects)
   ```bash
   # Download and run project setup script
   curl -O https://raw.githubusercontent.com/buihongduc132/orches-workflow/main/scripts/project-ensure-fields.sh
   chmod +x project-ensure-fields.sh
   ./project-ensure-fields.sh my-org 1  # Replace 1 with your project number
   ```

4. **Add GitHub Actions**
   ```bash
   # Create workflows directory
   mkdir -p .github/workflows
   
   # Download PR validation workflow
   curl -o .github/workflows/validate-pr-scope.yml \
     https://raw.githubusercontent.com/buihongduc132/orches-workflow/main/templates/rules/validate-pr-scope.yml
   ```

5. **Setup Branch Protection**
   ```bash
   # Protect main branch
   gh api repos/my-org/my-repo/branches/main/protection \
     --method PUT \
     --field required_status_checks='{"strict":true,"contexts":["validate"]}' \
     --field enforce_admins=true \
     --field required_pull_request_reviews='{"required_approving_review_count":1}' \
     --field restrictions=null
   ```

### For Existing Repositories

1. **Add Workflow Components**
   ```bash
   # Navigate to your existing repository
   cd /path/to/your/repo
   
   # Setup labels (preserves existing labels)
   /path/to/orches-workflow/scripts/labels-ensure.sh $(gh repo view --json owner,name -q '.owner.login + "/" + .name')
   ```

2. **Add GitHub Actions** (optional, review first)
   ```bash
   # Copy validation workflow (review and modify as needed)
   cp /path/to/orches-workflow/templates/rules/validate-pr-scope.yml .github/workflows/
   ```

## Organization-Wide Setup

### Using gh-dy-admin

1. **Setup Multiple Repositories**
   ```bash
   # List all repositories in organization
   gh repo list my-org --limit 100 --json name -q '.[].name' > repos.txt
   
   # Setup each repository
   while read repo; do
     echo "Setting up my-org/$repo"
     gh dy-admin setup labels --repo "my-org/$repo"
     gh dy-admin setup project --repo "my-org/$repo"
   done < repos.txt
   ```

2. **Bulk Project Setup**
   ```bash
   # Setup project fields for organization project
   gh dy-admin project ensure-fields --owner my-org --project 1
   ```

### Using Ansible (Automated Approach)

See the [Ansible Replication](#ansible-replication) section below.

## Configuration

### Environment Variables

Set these environment variables for easier usage:

```bash
# Default organization
export GITHUB_ORG="my-org"

# Default project number
export GITHUB_PROJECT="1"

# Add to your shell profile (.bashrc, .zshrc, etc.)
echo 'export GITHUB_ORG="my-org"' >> ~/.bashrc
echo 'export GITHUB_PROJECT="1"' >> ~/.bashrc
```

### GitHub CLI Configuration

```bash
# Set default repository format
gh config set git_protocol https

# Set default editor
gh config set editor vim

# Set default browser
gh config set browser firefox
```

## Ansible Replication

### Prerequisites for Ansible

1. **Install Ansible**
   ```bash
   # macOS
   brew install ansible
   
   # Ubuntu/Debian
   sudo apt install ansible
   
   # Python pip
   pip install ansible
   ```

2. **Install Required Collections**
   ```bash
   ansible-galaxy collection install community.general
   ansible-galaxy collection install ansible.posix
   ```

### Using the Ansible Playbook

1. **Create Inventory File**
   ```yaml
   # inventory.yml
   all:
     vars:
       github_token: "{{ lookup('env', 'GITHUB_TOKEN') }}"
       github_org: "my-org"
       github_project_number: 1
     hosts:
       localhost:
         ansible_connection: local
   ```

2. **Create Variables File**
   ```yaml
   # vars.yml
   repositories:
     - name: "repo1"
       private: true
     - name: "repo2" 
       private: false
   
   labels:
     - name: "ai-task"
       color: "1f883d"
       description: "Task for AI agents"
     - name: "human-review-needed"
       color: "fbca04"
       description: "Needs human attention"
   ```

3. **Run the Playbook**
   ```bash
   # Download the playbook
   curl -O https://raw.githubusercontent.com/buihongduc132/orches-workflow/main/ansible/replicate-workflow.yml
   
   # Run the playbook
   ansible-playbook -i inventory.yml -e @vars.yml replicate-workflow.yml
   ```

## Verification

### Test CLI Extensions

```bash
# Test basic functionality
gh dy --help
gh dy-admin --help

# Test repository detection
gh dy workflow describe

# Test label creation
gh dy-admin label ensure
```

### Test GitHub Actions

1. **Create Test PR**
   ```bash
   # Create test branch
   git checkout -b test-workflow
   echo "test" > test.txt
   git add test.txt
   git commit -m "Test workflow validation"
   git push origin test-workflow
   
   # Create PR
   gh pr create --title "Test PR" --body "Testing workflow validation"
   ```

2. **Verify Actions Run**
   ```bash
   # Check action status
   gh run list
   gh run view --log
   ```

## Troubleshooting

### Common Setup Issues

1. **Permission Denied**
   ```bash
   # Check GitHub authentication
   gh auth status
   
   # Re-authenticate if needed
   gh auth login --scopes repo,project,admin:org
   ```

2. **Extension Installation Fails**
   ```bash
   # Check extension directory
   ls ~/.local/share/gh/extensions/
   
   # Manually install
   git clone https://github.com/buihongduc132/gh-dy ~/.local/share/gh/extensions/gh-dy
   ```

3. **GitHub Actions Not Running**
   - Verify workflow file is in `.github/workflows/`
   - Check repository settings > Actions > General
   - Ensure branch protection rules are configured

### Getting Help

- Check the [Usage Guide](USAGE.md) for command examples
- Review [Quick Reference](QUICK_REFERENCE.md) for project structure
- Open issues in the [orches-workflow repository](https://github.com/buihongduc132/orches-workflow/issues)

## Next Steps

After setup:

1. Read the [Usage Guide](USAGE.md) to learn daily operations
2. Review [Quick Reference](QUICK_REFERENCE.md) for project navigation
3. Customize the workflow templates for your organization's needs
4. Train team members on the new workflow processes
