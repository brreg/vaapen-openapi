#!/bin/sh
echo "Generating all docs"
../vaapen-kodelister-api/gradlew generateOpenApiDocs -p ../vaapen-kodelister-api
../no.politiet.vaapen.blink.hendelse.api/gradlew generateOpenApiDocs -p ../no.politiet.vaapen.blink.hendelse.api
../no.politiet.vaapen.personlig.api/gradlew generateOpenApiDocs -p ../no.politiet.vaapen.personlig.api
../politiavgivelse-api/gradlew generateOpenApiDocs -p ../politiavgivelse-api
../no.politiet.vaapen.virksomhet.api/gradlew generateOpenApiDocs -p ../no.politiet.vaapen.virksomhet.api

echo "Fetching all openapi specs"
cp ../vaapen-kodelister-api/build/docs/kodelister.yaml .
cp ../no.politiet.vaapen.blink.hendelse.api/build/docs/blink-hendelse-api.yaml .
cp ../no.politiet.vaapen.personlig.api/build/docs/personlig-api.yaml .
cp ../politiavgivelse-api/build/docs/politiavgivelse-api.yaml .
cp ../no.politiet.vaapen.virksomhet.api/build/docs/virksomhet-api.yaml .

echo "Done!"