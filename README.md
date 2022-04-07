# Ribon Core Api

## How to run the project

Obs: You need rails installed to run those commands. You can check how to
install it [here](https://www.howtoforge.com/tutorial/ubuntu-ruby-on-rails/).

- clone this repository: `git clone git@github.com:RibonDAO/core-api.git`
- run the bundle install command: `bundle install`
- run the database setup command: `rails db:setup`
- run the rails server: `rails s`

You can check the http://localhost:3000/ and see if the Rails welcome page appears.

## How to run the tests

- run the command: `rspec`

## Environments
Currently there is a continuous deploy that sends the new versions of the code to 3 environments.
They are:
- Development: [development link](http://dev-api.eba-fktmq9bg.us-east-1.elasticbeanstalk.com/)
- Staging: [staging link](staging-dapp-api.ribon.io)
- Production: [production link](staging-dapp-api.ribon.io)

The development environment is where we can do tests. It is used by the front end development environment
as an api where the data is fetched. It is updated everytime the `develop` branch receives a new PR.

The staging environment is a replica of the production environment, but with a different database. We use them
to validate new features and test some things without damaging the production database. It is 
updated everytime a new PR is merged into the `main` branch.

The production enviroment is where the real users are. Everytime the `main` branch is updated, so the production environment is.

All the environments are hosted in the AWS elastic beanstalk environment. If you need to work on something related to this hosting,
call the Ribon developers team to have the access.
