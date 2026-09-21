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

Teste lokalt: i f.eks. IntelliJ, åpne `index.html` og klikk nettleser-ikonet i editor → "Open in Browser".

Commit og push:

```sh
git add .
git commit -m "Oppdaterte til siste versjon av OpenAPI-specs"
git push
```

### GitHub Actions feiler?

Prøv å [re-run jobben](https://github.com/brreg/vaapen-openapi/actions) via GitHub UI

### Automatisk oppdatering av swagger-ui

`update-swagger`-workflowen ([.github/workflows/update-swagger.yml](.github/workflows/update-swagger.yml)) kjører periodisk og sjekker om det finnes en nyere release av [swagger-ui](https://github.com/swagger-api/swagger-ui). Hvis versjonen i `swagger-ui.version` er utdatert, laster den ned den nye releasen, oppdaterer `dist/` og `index.html`, og oppretter en PR med endringene.

Som maintainer er du ansvarlig for å:

* Sjekke PR-en som blir opprettet
* Verifisere at `index.html` fortsatt fungerer lokalt (samme test som over: "Open in Browser")
* Merge PR-en ned til `master` når den er godkjent

Workflowen kan også trigges manuelt via [workflow_dispatch](https://github.com/brreg/vaapen-openapi/actions/workflows/update-swagger.yml).
