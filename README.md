Fragments
=========

Fragments is a tool for collaborative storytelling. By utilising visualisation, story contributors can track the
progression of a story, providing a way to easily see the branches of a story, helping to encourage branching.

In the interest of staying provider agnostic, the master branch of the project is generic production ready code 
that can be modified to deploy on any server/PaaS.

This branch (development) contains the latest project code, which may or may not be stable

The prototype is currently deployed [here](http://fragments-beta.herokuapp.com/)

# Development Environment

## Dependencies

- Ruby 2.2.0 or greater
- PostgreSQL (tested on PostgreSQL 9.4.1)
- [Mina](http://nadarei.co/mina/), if you intend to make use of the example deploy script

Installing these dependencies is beyond the scope of this README; Google should be your friend in this case.

## Setting up

- Clone this repository (`git clone https://github.com/narrativeandplay/fragments.git`)
- `cd /path/to/fragments/directory`
- Run `bundle install`

After which, doing `rails server` would start a local server, and the site will be available at http://localhost:3000

Copyright (c) 2013 Benedict Lee, licensed under the MIT License