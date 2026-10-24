#! /bin/bash

# =============================================================================
#  ENVIRONMENT VARIABLES IN LINUX: WHERE TO SET THEM & PRECEDENCE
# =============================================================================
#
#  RULE: Whatever loads LAST wins. Narrower scope overrides broader scope.
#        User settings override system settings.
#
# -----------------------------------------------------------------------------
#  PRECEDENCE (highest -> lowest)
# -----------------------------------------------------------------------------
#  1. Command prefix        VAR=x cmd           -> one command only
#  2. Inside a script       export VAR=x        -> script + its children
#  3. Current terminal      export VAR=x        -> until terminal closes
#  4. ~/.bashrc                                 -> one user, every new terminal
#  5. ~/.bash_profile / ~/.profile              -> one user, login shells
#  6. /etc/profile.d/*.sh                       -> all users, login shells
#  7. /etc/profile                              -> all users, login shells
#  8. /etc/environment                          -> all users, read by PAM at login
#
# -----------------------------------------------------------------------------
#  LOAD ORDER
# -----------------------------------------------------------------------------
#  Login shell (ssh, console login, bash -l, su - user):
#    /etc/environment -> /etc/profile -> /etc/profile.d/*.sh
#    -> FIRST found of: ~/.bash_profile | ~/.bash_login | ~/.profile
#    -> ~/.bashrc (only if ~/.bash_profile sources it)
#
#  Interactive non-login shell (new terminal tab, typing `bash`):
#    /etc/bash.bashrc (Debian/Ubuntu) or /etc/bashrc (RHEL) -> ~/.bashrc
#
#  Non-interactive shell (./script.sh, cron, CI):
#    Reads NONE of these files. Only inherits the parent's environment.
#    (This is why scripts work in your terminal but fail in cron.)
#
# =============================================================================
#  HOW TO SET VARIABLES IN EACH PLACE
# =============================================================================
#
#  1) /etc/environment  -> system-wide, plain KEY=value only
#     (no `export`, no $VAR expansion). Re-login to apply.
#       sudo vi /etc/environment
#       JAVA_HOME="/usr/lib/jvm/java-17"
#
#  2) /etc/profile.d/   -> RECOMMENDED for system-wide variables
#       sudo tee /etc/profile.d/myapp.sh <<'EOF'
#       export APP_ENV=prod
#       export PATH="$PATH:/opt/myapp/bin"
#       EOF
#       source /etc/profile.d/myapp.sh
#
#  3) /etc/profile      -> system-wide login shells
#     (avoid editing directly; OS updates may overwrite it)
#
#  4) /etc/bash.bashrc  -> system-wide interactive shells
#     (mostly for aliases and prompts)
#
#  5) ~/.bash_profile   -> per user, login shells
#       echo 'export AWS_PROFILE=dev' >> ~/.bash_profile
#       source ~/.bash_profile
#
#  6) ~/.bashrc         -> per user, every new terminal (most common)
#       echo 'export KUBECONFIG=$HOME/.kube/config' >> ~/.bashrc
#       source ~/.bashrc
#
#  7) Current session   -> lost when terminal closes
#       export LOG_LEVEL=debug
#
#  8) Inside a script   -> script and its child processes
#       export APP_ENV=staging
#
#  9) One command only  -> not saved anywhere
#       TZ=UTC date
#       LOG_LEVEL=debug ./app.sh
#
# =============================================================================
#  SERVICE-SPECIFIC PLACES (do NOT read .bashrc or /etc/profile)
# =============================================================================
#
#  systemd  -> /etc/systemd/system/myapp.service
#       [Service]
#       Environment="APP_ENV=prod"
#       EnvironmentFile=/etc/myapp/env
#     Apply: sudo systemctl daemon-reload && sudo systemctl restart myapp
#
#  cron     -> minimal environment; set vars at top of crontab -e
#       PATH=/usr/local/bin:/usr/bin:/bin
#       APP_ENV=prod
#       0 2 * * * /opt/scripts/backup.sh
#
#  sudo     -> resets most variables by default
#       sudo -E ./script.sh               # keep your environment
#       sudo APP_ENV=prod ./script.sh     # pass one variable
#       visudo: Defaults env_keep += "APP_ENV"   # permanent
#
#  Docker   -> `docker run -e` overrides Dockerfile ENV
#       docker run -e APP_ENV=prod --env-file .env myimage
#       Dockerfile: ENV APP_ENV=prod
#
#  Kubernetes -> explicit `env` overrides `envFrom`
#       env:
#         - name: APP_ENV
#           value: "prod"
#       envFrom:
#         - configMapRef: { name: app-config }
#         - secretRef:    { name: app-secrets }
#
# =============================================================================
#  VERIFY / DEBUG
# =============================================================================
#  echo "$VAR"                 # current value
#  printenv VAR                # only shows exported variables
#  env | grep VAR              # search the environment
#  declare -p VAR              # "declare -x" means exported
#  grep -r "VAR" /etc/environment /etc/profile /etc/profile.d \
#      ~/.bashrc ~/.bash_profile   # find where it is set
#  bash -lxc exit 2>&1 | grep VAR  # trace login startup files
#
# =============================================================================
#  RULES OF THUMB
# =============================================================================
#  - One user, every terminal  -> ~/.bashrc
#  - All users                 -> new file in /etc/profile.d/
#  - Services                  -> systemd Environment= / EnvironmentFile=
#  - cron jobs                 -> set in crontab or source inside the script
#  - Secrets                   -> NEVER in .bashrc or /etc/environment;
#                                 use Vault / AWS Secrets Manager / K8s Secrets
#  - VAR=x only lives in the current shell; export VAR=x passes a COPY to
#    child processes. Children can never change the parent's variables.
# =============================================================================
 
