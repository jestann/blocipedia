# Collab

A wiki collaboration app on Rails. Features free public and paid private collaboration spaces. Employs Devise and Pundit to implement differentiated collaborator permissions. Accepts payment via Stripe. Offers markdown rendering.

#### Build Frameworks

- [Ruby](https://www.ruby-lang.org/)
- [Rails](http://rubyonrails.org/)

#### Gems and Dependencies

- [Bootstrap](http://getbootstrap.com/)
- [Bcrypt](https://rubygems.org/gems/bcrypt/)
- [Figaro](https://rubygems.org/gems/figaro/)
- [SendGrid](https://sendgrid.com/)
- [Devise]()
- [Pundit]()
- [Stripe]()
- [RedCarpet]()

Also employs the following dev dependencies for testing, debugging, and seeding the development and test databases.

- [Shoulda]()
- [Faker]()
- [FactoryGirl]()
- [Pry]()

### Project Objectives

- Guests can find and view public collaboration spaces.
- Users can register for a free account.
- Users can join, edit, and create public collaboration spaces.
- Users can use markdown rendering to edit a collaboration space.
- Users can upgrade to a premium account by paying via Stripe.
- Premium users can create private collaboration spaces.
- Premium users can add and remove collaborators from their private collaboration spaces.
- Users who are collaborators on a private collaboration space can view and edit the space.
- Premium users can downgrade to the free account.
- Admin users can create, edit, and delete spaces and upgrade/downgrade users.

### Setup

A development version of this app can be run by cloning the repository, installing dependencies, and then running the rails server.

```
$ git clone https://github.com/jestann/collab.git <collab>
$ bundle install
$ rails s
```

### Configuration Variables

**Note:** This repository uses the file `application.yml` to initialize a Stripe account for accepting payment. This file is not included in the repository.

To run this app, developers must create a `application.yml` file with the appropriate information as given in `application.example.yml`:

```
STRIPE_PUBLISHABLE_KEY:
STRIPE_SECRET_KEY:
```

### Database Seeding

This app uses the `Faker` gem with some additional custom methods for generating effective test data and seeding the database via `seeds.rb`.

### Authentication and Authorization

This app uses `Devise` and `Pundit` gems for building authentication and for structuring customized authorization permissions for public and private spaces against ordinary and premium users. Custom `Pundit` authorization classes are included in `policies` under the `app` directory.

### Testing

This app includes a thorough set of tests, including differentiated authorization tests against `Pundit`, using `rspec` and `Shoulda` in the `spec` directory. Factories for test data generation using `FactoryGirl` are in the `factories` directory in the `spec` folder.

### File Structure

This app follows the standard Rails file structure.

```
├── app
│   ├── assets
│   │   ├── images
│   │   └── stylesheets
│   │       └── ...
│   ├── controllers
│   │   └── ...
│   ├── helpers
│   │   └── ...
│   ├── mailers
│   │   └── ...
│   ├── models
│   │   └── ...
│   ├── policies
│   │   └── ...
│   └── views
│       └── ...
├── bin
│   └── ...
├── config
│   ├── application.yml
│   └── ...
├── db
│   ├── seeds.rb
│   └── ...
├── lib
│   └── ...
├── log
│   └── ...
├── public
│   └── ...
├── spec
│   ├── controllers
│   │   └── ...
│   ├── factories
│   │   └── ...
│   ├── helpers
│   │   └── ...
│   ├── models
│   │   └── ...
│   ├── policies
│   │   └── ...
│   ├── views
│   │   └── ...
│   └── ...
├── test
│   └── ...
├── tmp
│   └── ...
├── vendor
│   └── ...
├── .gitignore
├── .rspec
├── config.ru
├── Gemfile
├── Rakefile
└── README.md
```

### Implementation

A test-drive version of the app exists [here](https://jestann-collab.herokuapp.com).

### Case Study

A description of the project case study exists [here](http://jessbird.me/portfolio/collab.html).

### Visuals

#### Main

<img alt="collab home 1" src="app/assets/images/readme/front-1.png" width="75%" align="center">

<img alt="collab home 2" src="app/assets/images/readme/front-2.png" width="75%" align="center">

#### Public Collaboration Space

<img alt="collab wiki" src="app/assets/images/readme/public.png" width="75%" align="center">

#### Private Collaboration Space

<img alt="collab team" src="app/assets/images/readme/private.png" width="75%" align="center">