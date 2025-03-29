# Environment Configuration Scripts

This directory contains scripts for managing environment configurations in the application.

## Setup Environment Script

`setup_env.sh` is used to copy the appropriate environment file to the root `.env` file based on the target environment.

### Usage

```bash
# Set up development environment (default)
./scripts/setup_env.sh dev

# Set up SIT environment
./scripts/setup_env.sh sit

# Set up UAT environment
./scripts/setup_env.sh uat

# Set up staging environment
./scripts/setup_env.sh staging

# Set up production environment
./scripts/setup_env.sh production
```

### Integration with Build Process

To integrate this with your build process, run the setup script before building the application:

```bash
# Example: Building for production
./scripts/setup_env.sh production
flutter build apk --release

# Example: Building for development
./scripts/setup_env.sh dev
flutter build apk --debug
```

### CI/CD Integration

For CI/CD pipelines, you can add the environment setup step before the build step:

```yaml
# Example for GitHub Actions
steps:
  - name: Setup environment
    run: ./scripts/setup_env.sh ${{ env.ENVIRONMENT }}
  
  - name: Build application
    run: flutter build apk --release
```
