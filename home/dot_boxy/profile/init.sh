set-option -g default-shell /usr/bin/zsh
sudo sh -c "$(curl -fsLS https://get.chezmoi.io/lb)" -- init --apply evankirkiles \
  --promptBool "Use HTTPS instead of SSH for git remotes"=true \
  --promptString "Git email address for the author/committer"=ekirkiles@makenotion.com \
  --promptMultichoice "Language ecosystems used on this computer"=frontend \
  --promptDefaults
