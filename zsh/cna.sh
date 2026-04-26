#!/bin/zsh
# designed to be a non-interactive opinionated setup for a new next.js app.
# run from the root of the project mkdir ~/Projects/<name> && cd ~/Projects/<name> && cna || curl -fsSL https://raw.githubusercontent.com/michaelmonetized/cna/main/cna.sh | zsh
# Remove tailwindcss plugins that are not upgraded for v4+
# add linkedom and other dependencies see ~/Projects/test-create-next-app/package.json and grep "bun i " ~/.zsh_history
PNAME="$(basename "$PWD")"; \
bunx --bun create-next-app@latest $PWD --yes --use-bun --app --eslint --agents-md && \
bun i --trust @tailwindcss/aspect-ratio @tailwindcss/container-queries @tailwindcss/forms @tailwindcss/typography tw-animate-css && \
bun tsc && \
bun lint --fix --max-warnings 9999 && \
npx shadcn@latest init -t next -b base -p lyra -n $PNAME --reinstall -fy >/dev/null && \
npx shadcn@latest add -ayo >/dev/null && \
git add . && \
git commit -am "init" && \
gh repo create $PNAME --private && \
git remote add origin https://github.com/michaelmonetized/$PNAME
git push && \
vercel link -yp $PNAME
