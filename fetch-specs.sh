#!/bin/bash
echo "Generating all docs"

my_dirs=("vaapen-kodelister-api" "no.politiet.vaapen.blink.hendelse.api" "no.politiet.vaapen.personlig.api" "politiavgivelse-api" "no.politiet.vaapen.virksomhet.api")

for dir in "${my_dirs[@]}"; do
  echo "Generating docs for $dir"
  cd "../$dir" || exit

  # Fetch latest from origin
  git fetch origin master

  # Get current branch name
  current_branch=$(git rev-parse --abbrev-ref HEAD)

  # Get local and remote commit hashes
  local_commit=$(git rev-parse HEAD)
  remote_commit=$(git rev-parse origin/master)

  # Check if on master and in sync
  if [ "$current_branch" = "master" ] && [ "$local_commit" = "$remote_commit" ]; then
    echo "On master and in sync with origin/master. Proceeding..."
    gradlew clean cleanDependencies generateOpenApiDocs
  else
    echo "Not on master or not in sync with origin/master. Aborting."
    exit 1
  fi
done

cd ../vaapen-openapi || exit

echo "Fetching all openapi specs"
cp ../vaapen-kodelister-api/build/docs/kodelister.yaml .
cp ../no.politiet.vaapen.blink.hendelse.api/build/docs/blink-hendelse-api.yaml .
cp ../no.politiet.vaapen.personlig.api/build/docs/personlig-api.yaml .
cp ../politiavgivelse-api/build/docs/politiavgivelse-api.yaml .
cp ../no.politiet.vaapen.virksomhet.api/build/docs/virksomhet-api.yaml .

echo "Done!"