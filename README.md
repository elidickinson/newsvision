# newsvision

Software to display newspaper headlines on a Visionect Place & Play 32 eInk display panel.

## Set up

```
cp env.list.sample env.list
```
and then edit env.list to include your IDs and API keys

Build the docker image:
```
docker build . --tag newsvision
```

## Executing

Send a random newspaper frontpage:
```
docker run --env-file env.list --rm newsvision
```

Send a particular newspaper frontapge
```
docker run --env-file env.list --rm newsvision /paperme.sh DC_WP
```

See paperindex.tsv for list of options

## Updating paperindex

`curl https://api.freedomforum.org/cache/papers.js |  jq -r '.[] | [.paperId, .title, .location] | @tsv' > paperindex.tsv`