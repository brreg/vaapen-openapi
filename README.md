# Oppdatere Swagger

## Rutine for å oppdatere Swagger-spesifikasjoner.

Repo: [brreg/vaapen-openapi](https://github.com/brreg/vaapen-openapi)

Publisert dokumentasjon:

* [blink-hendelse-api dokumentasjon](https://brreg.github.io/vaapen-openapi/)
* [politiavgivelse-api dokumentasjon](https://brreg.github.io/vaapen-openapi/?url=politiavgivelse-api.yaml)
* [kodelister dokumentasjon](https://brreg.github.io/vaapen-openapi/?url=kodelister.yaml)
* [virksomhet-api dokumentasjon](https://brreg.github.io/vaapen-openapi/?url=virksomhet-api.yaml)
* [personlig-api dokumentasjon](https://brreg.github.io/vaapen-openapi/?url=personlig-api.yaml)

## Steg

Sjekk at du er på `master` og i synk:

```sh
git checkout master
git pull
```

Pass på at de komponentene du henter fra også er hentet fra siste master.

Hent specs:

```sh
./fetch-specs.sh
```

Commit og push:

```sh
git add .
git commit -m "Oppdaterte til siste versjon av OpenAPI-specs"
git push
```

### 3. GitHub Actions feiler?

Prøv å [re-run jobben](https://github.com/brreg/vaapen-openapi/actions) via GitHub UI