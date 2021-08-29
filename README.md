# Mongo DB Test Data Preperation Workbench



Requires one of the following environments:
- Linux with Make and Bash installed
- Windows with WSL 2 installed
- Mac OS X
- or any unix like environment with GNU make and BASH
Also requires a local mongodb setup

Uses the following tools
- bash
- mgodatagen
- mongosh
- mongoimport
- monogexport

## Recomended Workflow:
1) run `make clean`
2) run `make download-schema-from-host`
3) edit the `export-config.json` file using your favorite json editor and using the `export-config.json.example` as an example to fit your situation based on what you learned from the downloadedSchemaFiles
4) run `make generate`
5) run `make export`
6) edit files in the exports folder if needed
7) run `make copy-to-import`
8) run `make import`

## Required environmental variables:

| Environmental Variable | Purpose |
| ---------------------- | ------------------------------------------ |
| MONGOURI | Server to download current schema from |
| MONGOSRCEXPURI | Server to export from |
| MONGODESTIMPURI | Server to import test schema files to |
