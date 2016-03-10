# Intro

Easily run [github-leaderboard](https://github.com/eugef/github-leaderboard) with Docker.

# Run

See the [Makefile](Makefile) for available tasks, but generally [create a Github token](https://github.com/settings/tokens/new), and then:

    export GITHUB_TOKEN="<your github token>"
    make build
    make update ARGS="org1 org2"
    make start

# TODO

Currently only supports `orgs`, and will support `users` too (although, presumably you'd only want to leaderboard your orgs).
