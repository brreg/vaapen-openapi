# Oppdatere Swagger

Rutine for å oppdatere Swagger-spesifikasjoner.

Repo: [brreg/vaapen-openapi](https://github.com/brreg/vaapen-openapi)

## Steg

### 1. `vapen-openapi`

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

Prøv å [re-run jobben](https://github.com/brreg/vaapen-openapi/actions) via GitHub UI, eller med `gh` CLI:

```shell
gh run rerun --failed
```