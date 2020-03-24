# Adoptoposs

[![Build Status](https://github.com/paulgoetze/adoptoposs/workflows/Elixir%20CI/badge.svg)](https://github.com/paulgoetze/adoptoposs/workflows/Elixir%20CI/badge.svg)

Finding co-maintainers for your open source software project. 

## Development setup

The app comes with a docker image for development. 
In order to setup the development environment you need to have some dependencies installed on your machine:

- [docker engine](https://docs.docker.com/install/)
- [docker-compose](https://docs.docker.com/compose/install/)
- [git](https://git-scm.com/downloads)

Checkout the Adoptoposs repository with

```
$ git clone git@github.com:paulgoetze/adoptoposs.git
```

Then step into the project and run the setup make task. This will build the docker container, create a development config, install all dependencies and setup development & test databases:

```
$ cd adoptoposs && make setup
```

Next, start the development server with:

```
$ make up
```

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.


For further detail on available make tasks please have a look into the task list:

```
$ make usage
```

# Copyright and License

Copyright (c) 2020, Paul Götze

Adoptoposs is licensed under the [MIT License](https://github.com/paulgoetze/adoptoposs/blob/master/LICENSE.md).
