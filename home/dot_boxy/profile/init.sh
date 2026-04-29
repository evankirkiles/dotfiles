set-option -g default-shell /usr/bin/zsh
sudo sh -c "$(curl -fsLS https://get.chezmoi.io/lb)" -- init --apply evankirkiles \
  --promptString email=ekirkiles@makenotion.com \
  --promptMultichoice languages=frontend
