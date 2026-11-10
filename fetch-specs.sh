#!/bin/bash
# Bruk: ./fetch-specs.sh [--any-branch]
# Pull-er gjeldende branch med --ff-only. --any-branch lar skriptet kjøre også på andre branches

RED=$'\033[31m'
GREEN=$'\033[32m'
BLUE=$'\033[34m'
RESET=$'\033[0m'

feilmelding() {
  echo "${RED}❌ $1${RESET}"
}

info() {
  echo "${BLUE}$1${RESET}"
}

suksess() {
  echo "${GREEN}✅ $1${RESET}"
}

any_branch=false
if [ "$1" = "--any-branch" ]; then
  any_branch=true
fi

my_dirs=("vaapen-kodelister-api" "no.politiet.vaapen.blink.hendelse.api" "no.politiet.vaapen.personlig.api" "politiavgivelse-api" "no.politiet.vaapen.virksomhet.api")

if [ "$any_branch" = false ]; then
  info "🔍 Checking branches"
  feil=false
  for dir in "${my_dirs[@]}"; do
    branch=$(git -C "../$dir" rev-parse --abbrev-ref HEAD) || exit 1
    if [ "$branch" != "master" ]; then
      feilmelding "$dir is on branch '$branch', not master"
      feil=true
    fi
  done
  if [ "$feil" = true ]; then
    feilmelding "Aborting. Use --any-branch to override."
    exit 1
  fi
  suksess "All repos on master"
fi

info "🚀 Generating all docs"

for dir in "${my_dirs[@]}"; do
  info "📦 Generating docs for $dir"
  cd "../$dir" || exit 1

  git pull --ff-only || { feilmelding "git pull failed in $dir"; exit 1; }

  ./gradlew clean cleanDependencies generateOpenApiDocs || { feilmelding "Gradle failed in $dir"; exit 1; }
  suksess "$dir done"
done

cd ../vaapen-openapi || exit 1

info "📥 Fetching all openapi specs"
cp ../vaapen-kodelister-api/build/docs/kodelister.yaml . || exit 1
cp ../no.politiet.vaapen.blink.hendelse.api/build/docs/blink-hendelse-api.yaml . || exit 1
cp ../no.politiet.vaapen.personlig.api/build/docs/personlig-api.yaml . || exit 1
cp ../politiavgivelse-api/build/docs/politiavgivelse-api.yaml . || exit 1
cp ../no.politiet.vaapen.virksomhet.api/build/docs/virksomhet-api.yaml . || exit 1

suksess "Done!"
