#!/bin/sh

cd /home/builduser/plugin
rm -rf /home/builduser/plugin/node_modules/

if ! pnpm i --frozen-lockfile;
then
  printf "error code: %s\npnpm lockfile not found or other error occurred, please report this issue to the CI maintainer and the plugin developer." "$?"
  exit 1
fi

if ! pnpm run build;
then
  printf "error code: %s\npnpm build failed, please report this issue to the CI maintainer and the plugin developer." "$?"
  exit 1
fi

rsync -r --exclude "src/" --exclude "__pycache__" --exclude "node_modules" /home/builduser/plugin/ /home/builduser/plugin-out/
