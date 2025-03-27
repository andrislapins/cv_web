#!/bin/bash

npm create vite@latest
code cv-web-frontend/

npm i eslint-plugin-react-x eslint-plugin-react-dom

xdg-mime default firefox_firefox.desktop x-scheme-handler/https x-scheme-handler/http
npm run dev

npm i -D eslint
npx eslint --init

# I don't know how to include it into eslint.config.js
# npx install-peerdeps --dev eslint-config-airbnb

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# version taken from .nvmrc
nvm install
nvm use
nvm ls
npm install

# Generate API model
npm run gen
# Compile and Hot-Reload for Development
npm run dev
# Type-Check, Compile and Minify for Production
npm run dev

npm i -D prettier eslint-config-prettier eslint-plugin-prettier

# Consider using lint-staged + husky to only lint and format files you're committing